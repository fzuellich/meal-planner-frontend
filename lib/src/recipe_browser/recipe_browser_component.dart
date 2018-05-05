import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';

import 'package:meal_planner_frontend/src/common/board.dart';
import 'package:meal_planner_frontend/src/common/recipe.dart';
import 'package:meal_planner_frontend/src/common/recipe_name_pipe.dart';
import 'package:meal_planner_frontend/src/common/recipe_service.dart';

@Component(
  selector: 'recipe-browser',
  templateUrl: 'recipe_browser_component.html',
  styleUrls: const ['recipe_browser_component.css'],
  directives: const [NgFor, NgIf],
  pipes: const [ReplacePipe, RecipeNamePipe],
  providers: const [RecipeService])

class RecipeBrowserComponent {

  static final String RECIPE_SELECTOR = '.recipe-browser__recipe';

  final RecipeService _recipeService;

  List<Recipe> recipes = [];
  List<Recipe> displayRecipes = [];

  final _recipeChange = new StreamController<bool>();
  @Output()
  Stream<bool> get recipeChange => _recipeChange.stream;

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
      this.displayRecipes = recipes;
      _recipeChange.add(true);
    });
  }

  void filterRecipes(String value) {
    displayRecipes = new List.from(recipes);

    if (value != null && value.trim().isNotEmpty) {
      displayRecipes.retainWhere((Recipe recipe) => recipe.name.toLowerCase().contains(value));
    }
  }

  final _selectedRecipe = new StreamController<Recipe>();
  @Output()
  Stream<Recipe> get recipeSelected => _selectedRecipe.stream;

  void addRecipe(Recipe recipe) {
    _selectedRecipe.add(recipe);
  }
}