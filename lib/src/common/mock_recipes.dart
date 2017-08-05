import 'recipe.dart';

final Map<String, List<Recipe>> mockRecipes = {
  "1" : [
    new Recipe.withData("1-01", "Recipe 01", "This is a recipe for board 1"),
    new Recipe.withData("1-02", "Recipe 02", "This is a recipe for board 1"),
    new Recipe.withData("1-03", "Recipe 03", "This is a recipe for board 1"),
  ],
  "2" : [
    new Recipe.withData("2-01", "Recipe 01", "This is a recipe for board 2"),
    new Recipe.withData("2-02", "Recipe 02", "This is a recipe for board 2"),
    new Recipe.withData("2-03", "Recipe 03", "This is a recipe for board 2"),
  ]
};