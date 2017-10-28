import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:meal_planner_frontend/src/common/mock_recipes.dart';
import 'package:meal_planner_frontend/src/common/recipe.dart';

@Injectable()
class RecipeService {

  Future<Recipe> getRecipe(String recipeId) async {
    for(List<Recipe> recipes in mockRecipes.values) {
      for(Recipe recipe in recipes) {
        if (recipe.id == recipeId) {
          return recipe;
        }
      }
    }

    return null;
  }

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