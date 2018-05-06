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

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [NgIf, APP_COMPONENTS],
  providers: const [IngredientService],
)
class AppComponent extends AfterViewInit {

  static const bool DEBUG_MODE = false;

  IngredientService _ingredientService;

  List<IngredientRetrievalStatus> ingredientRetrievalStatus = [];
  List<ShoppingListItem> shoppingListItems = [];
  Board selectedBoard = null;
  List<Recipe> selectedRecipes = [];
  bool loggedIn = false;

  AppComponent(this._ingredientService);

  void addSelectedRecipeToList(Recipe selected) {
    _resetShoppingList();
    _resetIngredientRetrievalStatus();
    selectedRecipes.add(selected);
  }

  void removeRecipeFromSelection(Recipe remove) {
    selectedRecipes.remove(remove);
  }

  Future gatherIngredients() async {
    _resetIngredientRetrievalStatus();
    _resetShoppingList();
    _resetBoardSelection();

    List<Recipe> copyOfTimeTableSlots = new List.from(selectedRecipes);
    copyOfTimeTableSlots.removeWhere((recipe) => recipe == null);

    await copyOfTimeTableSlots.forEach((recipe) async {
      IngredientRetrievalStatus status = new IngredientRetrievalStatus();
      ingredientRetrievalStatus.add(status);
      status.info = "Gathering ingredients...";
      status.recipe = recipe;
      status.failed = false;

      List<Ingredient> ingredients = await _ingredientService.getIngredients(recipe);
      status.info = "Found ${ingredients.length} ingredients.";
      status.failed = ingredients.isEmpty;

      shoppingListItems.addAll(ingredients.map((Ingredient i) => new ShoppingListItem('${i.amount}x ${i.unit} ${i.name}')));
    });
  }

  void _resetBoardSelection() {
    selectedBoard = null;
  }

  void _resetShoppingList() {
    shoppingListItems = [];
  }

  void _resetIngredientRetrievalStatus() {
    ingredientRetrievalStatus = [];
  }

  @override
  ngAfterViewInit() async {
    const String _SERVICE_URL = 'https://localhost:8443/status';
    var string = await HttpRequest.getString(_SERVICE_URL);
    loggedIn = string == "true";
  }
}
