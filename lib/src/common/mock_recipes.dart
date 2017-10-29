import 'recipe.dart';
import 'mock_ingredient.dart';

final Map<String, List<Recipe>> mockRecipes = {
  "1" : [
    new Recipe.withData("1-01", "Recipe B0101", "This is a recipe for board 1", listOfMockIngredients),
    new Recipe.withData("1-02", "Recipe B0102", "This is a recipe for board 1", listOfMockIngredients),
    new Recipe.withData("1-03", "Recipe B0103", "This is a recipe for board 1", listOfMockIngredients),
  ],
  "2" : [
    new Recipe.withData("2-01", "Recipe B0201", "This is a recipe for board 2", listOfMockIngredients),
    new Recipe.withData("2-02", "Recipe B0202", "This is a recipe for board 2", listOfMockIngredients),
    new Recipe.withData("2-03", "Recipe B0203", "This is a recipe for board 2", listOfMockIngredients),
  ]
};