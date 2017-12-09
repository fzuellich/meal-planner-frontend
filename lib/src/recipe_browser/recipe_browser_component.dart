import 'dart:html';
import 'package:angular2/angular2.dart';

import 'package:meal_planner_frontend/src/common/board.dart';
import 'package:meal_planner_frontend/src/common/recipe.dart';
import 'package:meal_planner_frontend/src/common/recipe_service.dart';

@Component(
  selector: 'recipe-browser',
  templateUrl: 'recipe_browser_component.html',
  styleUrls: const ['recipe_browser_component.css'],
  directives: const [NgFor, NgIf],
  providers: const [RecipeService])

class RecipeBrowserComponent {

  static final String RECIPE_SELECTOR = '.recipe-browser__recipe';

  final RecipeService _recipeService;

  List<Recipe> recipes = [];

  Board _board;

  @Input()
  set board(Board board) {
    _board = board;

    if (board.id != null && board.id.isNotEmpty) {
      getRecipes();
    } else {
      recipes = [];
    }
  }

  Board get board => _board;

  RecipeBrowserComponent(this._recipeService);

  void getRecipes() {
    _recipeService.getRecipes(board.id).then((recipes) {
      this.recipes = recipes;
    });
  }

}