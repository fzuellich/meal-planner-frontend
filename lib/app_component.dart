import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';

import 'package:dnd/dnd.dart';
import 'package:meal_planner_frontend/src/common/app_components.dart';
import 'package:meal_planner_frontend/src/common/board.dart';
import 'package:meal_planner_frontend/src/common/ingredient.dart';
import 'package:meal_planner_frontend/src/common/ingredient_retrieval_status.dart';
import 'package:meal_planner_frontend/src/common/ingredient_service.dart';
import 'package:meal_planner_frontend/src/common/recipe.dart';
import 'package:meal_planner_frontend/src/common/recipe_service.dart';
import 'package:meal_planner_frontend/src/common/shoppping_list_item.dart';
import 'package:meal_planner_frontend/src/common/timetable_slot.dart';
import 'package:meal_planner_frontend/src/recipe_browser/recipe_browser_component.dart';
import 'package:meal_planner_frontend/src/timetable/timetable_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [NgIf, APP_COMPONENTS],
  providers: const [RecipeService, IngredientService],
)
class AppComponent implements AfterViewChecked {

  static const bool DEBUG_MODE = true;

  RecipeService _recipeService;
  IngredientService _ingredientService;

  Draggable _previousDraggable = null;
  Dropzone _previousDropzone = null;
  bool _recipeChanged = false;

  List<IngredientRetrievalStatus> ingredientRetrievalStatus = [];
  List<ShoppingListItem> shoppingListItems = [];
  Board selectedBoard = null;
  List<TimetableSlot> timetableSlots = _createTimeTableForNextWeek();

  AppComponent(this._recipeService, this._ingredientService);

  /**
   * Instead of writing a custom setter for the selectBoard property, w  String shoppingListProgressMessage = "";e rely on
   * the event published by the RecipeBrowser component. In combination with the
   * ngAfterViewChecked event, this is a more precise and easier version.
   *
   * For example we already know the recipes are loaded and therefore probably
   * rendered by the browser.
   */
  void selectedBoardChanged() {
    _recipeChanged = true;
  }

  void createDraggable() {
    if (_recipeChanged == false) {
      return;
    }

    if (_previousDraggable != null) {
      _previousDraggable.destroy();
    }

    ElementList<Element> elements = querySelectorAll(RecipeBrowserComponent.RECIPE_SELECTOR);
    Draggable draggable = new Draggable(elements, avatarHandler: new AvatarHandler.clone());
    _previousDraggable = draggable;
    _recipeChanged = false;
  }

  void createDropzone() {
    if (_previousDropzone != null) {
      return;
    }

    ElementList<Element> dropZones = querySelectorAll(TimetableComponent.DROPZONE_SELECTOR);
    Dropzone dropzone = new Dropzone(dropZones);
    dropzone.onDrop.listen((DropzoneEvent e) {
      final String recipeId = e.draggableElement.attributes['data-recipeId'];
      final String dropZoneIndexRaw = e.dropzoneElement.attributes['data-dropzoneIndex'];
      final int dropZoneIndex = int.parse(dropZoneIndexRaw);

      _recipeService.getRecipe(recipeId).then((recipe) => timetableSlots[dropZoneIndex].recipe = recipe);
    });

    _previousDropzone = dropzone;
  }

  @override
  ngAfterViewChecked() {
    ElementList<Element> recipeElements = querySelectorAll(RecipeBrowserComponent.RECIPE_SELECTOR);

    if (recipeElements.length > 0) {
      createDraggable();
      createDropzone();
    }
  }

  Future gatherIngredients() async {
    ingredientRetrievalStatus = [];
    List<TimetableSlot> copyOfTimeTableSlots = new List.from(timetableSlots);
    copyOfTimeTableSlots.removeWhere((slot) => slot.recipe == null);

    await copyOfTimeTableSlots.forEach((slot) async {
      IngredientRetrievalStatus status = new IngredientRetrievalStatus();
      ingredientRetrievalStatus.add(status);
      status.info = "Gathering ingredients...";
      status.recipe = slot.recipe;
      status.failed = false;

      List<Ingredient> ingredients = await _ingredientService.getIngredients(slot.recipe);
      status.info = "Found ${ingredients.length} ingredients.";
      status.failed = ingredients.isEmpty;

      shoppingListItems.addAll(ingredients.map((Ingredient i) => new ShoppingListItem('${i.amount}x ${i.unit} ${i.name}')));
    });
  }

  static List<TimetableSlot> _createTimeTableForNextWeek() {
    List<TimetableSlot> slotsForNextWeek = new List();
    final DateTime today = new DateTime.now();

    for (int i = 0; i < 7; i++) {
      slotsForNextWeek.add(new TimetableSlot(today.add(new Duration(days: i)), null));
    }

    return slotsForNextWeek;
  }

}
