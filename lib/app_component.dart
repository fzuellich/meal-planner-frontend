import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import 'package:dnd/dnd.dart';
import 'package:meal_planner_frontend/src/common/board.dart';
import 'package:meal_planner_frontend/src/common/ingredient.dart';
import 'package:meal_planner_frontend/src/common/recipe_service.dart';
import 'package:meal_planner_frontend/src/common/timetable_slot.dart';
import 'package:meal_planner_frontend/src/recipe_browser/recipe_browser_component.dart';
import 'package:meal_planner_frontend/src/shopping_list/shopping_list_component.dart';
import 'src/board_browser/board_browser_component.dart';
import 'package:meal_planner_frontend/src/timetable/timetable_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [NgIf, materialDirectives, BoardBrowserComponent, RecipeBrowserComponent, TimetableComponent, ShoppingListComponent],
  providers: const [materialProviders, RecipeService],
)
class AppComponent implements AfterViewChecked {

  RecipeService _recipeService;

  List<Ingredient> listOfIngredients = [];

  AppComponent(this._recipeService);

  Dropzone _previousDropzone = null;

  bool boardBrowserViewInit = false;

  // Keep the last draggable so we can destroy it.
  Draggable _previousDraggable = null;

  Board selectedBoard = null;

  List<TimetableSlot> timetableSlots = _createTimeTableForNextWeek();

  void createDraggable() {
    if (_previousDraggable != null) {
      return;
    }

    ElementList<Element> elements = querySelectorAll(RecipeBrowserComponent.RECIPE_SELECTOR);
    Draggable draggable = new Draggable(elements, avatarHandler: new AvatarHandler.clone());
    _previousDraggable = draggable;
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

  void gatherIngredients() {
    List<TimetableSlot> copyOfTimeTableSlots = new List.from(timetableSlots);
    copyOfTimeTableSlots.removeWhere((slot) => slot.recipe == null);

    List<Ingredient> finalListOfIngredients = new List();
    copyOfTimeTableSlots.forEach((slot) {
      finalListOfIngredients.addAll(slot.recipe.ingredients);
    });

    listOfIngredients = finalListOfIngredients;
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
