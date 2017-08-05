import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:meal_planner_frontend/src/common/mock_recipes.dart';
import 'package:meal_planner_frontend/src/common/recipe.dart';

@Injectable()
class RecipeService {

  /**
   * Return all recipes for a given board. Empty list if no recipes for board
   * found.
   */
  Future<List<Recipe>> getRecipes(String boardId) async {
    if (mockRecipes.containsKey(boardId)) {
      return mockRecipes[boardId];
    } else {
      return [];
    }
  }
}