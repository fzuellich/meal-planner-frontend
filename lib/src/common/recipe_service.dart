import 'dart:async';

import 'dart:convert';
import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:meal_planner_frontend/src/common/mock_recipes.dart';
import 'package:meal_planner_frontend/src/common/recipe.dart';

@Injectable()
class RecipeService {

  static const String _SERVICE_URL = 'https://localhost:8443/board?boardId=%';

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
    return _fetchRecipesForBoard(boardId);
    if (mockRecipes.containsKey(boardId)) {
      return mockRecipes[boardId];
    } else {
      return _fetchRecipesForBoard(boardId);
    }
  }

  Future<List<Recipe>> _fetchRecipesForBoard(String boardId) async {
    String url = _SERVICE_URL.replaceAll('%', boardId);
    String json = await HttpRequest.getString(url);
    //String json = '{"board":{"id":"570479546487730334","name":"Kitchen Playtime Approved","url":"https://www.pinterest.com/whocares_/kitchen-playtime-approved/"},"pins":[{"id":"570479477788387803","link":"https://www.pinterest.com/r/pin/570479477788387803/4909326455481059033/8ba07160fc8ee72dde2c5533e06608074050d013447c2de7131ec80356cfdf1d","note":"Zart geschmortes Rindfleisch, Wurzelgemüse und ein großzügiger Schuss Guinness verleihen diesem Wohlfühl-Gericht seinen unwiderstehlichen Geschmack.","name":"Irischer Rindfleischeintopf mit Guinness"},{"id":"570479477786985105","link":"https://www.pinterest.com/r/pin/570479477786985105/4909326455481059033/f4a9e7c7383abe20141a429b17b10e151709ab682457a1115611e751dc1a7299","note":"Spaghetti With Carbonara Sauce","name":""},{"id":"104286547604296423","link":"https://www.pinterest.com/r/pin/104286547604296423/4909326455481059033/0403ad50978f71deaf74bd7319e511d2e5267bf0c389657af6f37ea92d6f2723","note":"Weekday Meal-Prep Chicken Teriyaki Stir-Fry","name":"Make This For Your Next Weekday Meal Prep"},{"id":"104286547602887439","link":"https://www.pinterest.com/r/pin/104286547602887439/4909326455481059033/33bced9d091c104025b1a008f6fd931bbb0ae87cc1683f86417d61ca82d980d4","note":"This rich and Creamy Mushroom Herb Pasta is a surprisingly fast and simple to way to have a gourmet meal at home. @budgetbytes","name":"Creamy Mushroom Herb Pasta"},{"id":"570479477784869831","link":"https://www.pinterest.com/r/pin/570479477784869831/4909326455481059033/cd00d151e614038a127838c9865c4910384bde9c0eb0498fe5d1d4770f07bcd2","note":"Easy One-Pot, No-Knife, Lighter Tuna Noodle Casserole Recipe","name":""},{"id":"570479477784857022","link":"https://www.pinterest.com/r/pin/570479477784857022/4909326455481059033/a43a75873dbb4c62eae2249555218ce73aaf3f0a584c9a82d651c3be0d3e5a6d","note":"Use Mahatma Jasmine Rice to create this super flavorful, quick, and easy Chicken Fried Rice. A must-try recipe!","name":"Gluten Free Chicken Fried Rice"},{"id":"570479477784462011","link":"https://www.pinterest.com/r/pin/570479477784462011/4909326455481059033/d3ad195ee6201bdb3cc13b0cde0f47be536816548fa6544c3be2bae7d4882f2d","note":"This recipe is the perfect mushroom risotto recipe. Fool-proof simple, perfect meatless main dish or side. Company worthy, easily adapted for a vegan main dish as well.","name":"Perfect Mushroom Risotto with Risotto Tutorial"},{"id":"570479477782710422","link":"https://www.pinterest.com/r/pin/570479477782710422/4909326455481059033/bc152e07309691d8ae7c17b86445d5d077d034144bd720fcb87c27277c23c295","note":" ","name":"How to Make Crepe-Style Manicotti"},{"id":"570479477782667620","link":"https://www.pinterest.com/r/pin/570479477782667620/4909326455481059033/177586ba13827275a46d6110c08aa8feecf550a6611f630aeb9888891f995a39","note":" ","name":""},{"id":"570479477780687318","link":"https://www.pinterest.com/r/pin/570479477780687318/4909326455481059033/1d8c37dfd1ec041e563185a2358797885820b9ca195c5a8ba09c52f5f84d6fef","note":"Authentic Greek Tzatziki Dip - learned in Athens!","name":"Authentic Greek Tzatziki"},{"id":"570479477780687263","link":"https://www.pinterest.com/r/pin/570479477780687263/4909326455481059033/a3ad6534501555e550420de740c899296f11040a8748e7c2f7e0f8dbbf5aa624","note":"Sautéed shrimp with caramelized lemons, tossed with shallots, spinach and linguine. The trick that takes this recipe over the top? Caramelizing the lemon. So good! On SimplyRecipes.com","name":""},{"id":"570479477780579602","link":"https://www.pinterest.com/r/pin/570479477780579602/4909326455481059033/3a878a551c85dd73a6cec3343b6d49e764bc7b5f76765538563c385bd4d29387","note":"Asparagus Eggs Benedict | Kwestia Smaku","name":""},{"id":"570479477780364127","link":"https://www.pinterest.com/r/pin/570479477780364127/4909326455481059033/d897335be03f348910a0eea214cdf75fa24e1b2e52a158a613118b8233dfeb26","note":"Spinach and Feta Quesadillas","name":"Spinach and Feta Quesadillas"},{"id":"570479477780327283","link":"https://www.pinterest.com/r/pin/570479477780327283/4909326455481059033/5441003966f93335fc4845fc145b023b486bd27674292b6b8a761bd4ca85c754","note":"Shrimp Fried Rice - Why order take-out? This homemade version is so much healthier, cheaper and tastes a million times better!","name":"Shrimp Fried Rice"},{"id":"570479477780123052","link":"https://www.pinterest.com/r/pin/570479477780123052/4909326455481059033/61a90ca1212a5ab71e95dd78be89f1c24aa47857db4ddbdc1507b8bb06b6cc79","note":"Salmon with Quinoa Feta and Spinach recipe is delicious, healthy and done in less than 30 minutes.","name":"Salmon with Quinoa Feta and Spinach"},{"id":"570479477780055472","link":"https://www.pinterest.com/r/pin/570479477780055472/4909326455481059033/56d5721cf0ea7ce26b363b9b1b27ba85f37450498563bba4bcab9dc99206a8f6","note":"Baked Salmon and Asparagus in Foil - this is one of the easiest dinners ever, it tastes amazing, it\'s perfectly healthy and clean up is a breeze!","name":""},{"id":"570479477779475296","link":"https://www.pinterest.com/r/pin/570479477779475296/4909326455481059033/5af8547b99773ebd4a0dfafc8dcad62d6c5e1fc24a6b744038b2b9d3a8ff243c","note":"RIAZZOLI.: summer lunch.","name":""},{"id":"570479477779403626","link":"https://www.pinterest.com/r/pin/570479477779403626/4909326455481059033/32bf66bcf4d373dec6362fc7d1dfc593e0f03fe4859ef406375dcca7fa051461","note":"One Pot Spicy Thai Noodles - these are SO good and so easy to cook up. Vegetarian recipe but options for added protein too!","name":""},{"id":"570479477779403621","link":"https://www.pinterest.com/r/pin/570479477779403621/4909326455481059033/5d01b5cc4fa9f00270b3f970c89f77601cfc6d4922f710b9d6fa8462b4b49fb5","note":"Extra Crispy Sweet Potato Wedges - oven baked and made with simple ingredients. These are SO addicting!","name":"Extra Crispy Sweet Potato Wedges"},{"id":"570479477779403543","link":"https://www.pinterest.com/r/pin/570479477779403543/4909326455481059033/82d357b2782816d2b75ba884ba1767d64cd51286b7cb332743c527326fc3453b","note":"Vegan und selbstgemacht: Süßkartoffel-Gnocchi mit Pilzen. Alternativ geht auch Kürbis.","name":""},{"id":"570479477779403513","link":"https://www.pinterest.com/r/pin/570479477779403513/4909326455481059033/686f5cbb9d55c0eccbb712522ec7d79f8a70100bb2b6598bd4b55dfeb118842d","note":"Pasta with Tomato Cream {Amazing!} Add chicken, add shrimp, add nothing, this recipe is SOLID.","name":"Pasta with Tomato Cream Sauce"}]}';
    var recipeJSON = JSON.decode(json)['pins'];
    List<Recipe> recipes = recipeJSON
        .map((recipe) => _createRecipeFromJSON(recipe))
        .toList();

    return recipes;
  }

  Recipe _createRecipeFromJSON(var recipe) {
    return new Recipe.withData(recipe['id'], recipe['name'], recipe['note'], []);
  }
}