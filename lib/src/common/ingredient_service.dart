import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:meal_planner_frontend/src/common/ingredient.dart';
import 'package:meal_planner_frontend/src/common/recipe.dart';

@Injectable()
class IngredientService {

  static const String _SERVICE_URL = 'https://localhost:8443/parse?url=%';


  Future<List<Ingredient>> getIngredients(Recipe recipe) async {
//    if (recipe.link == null) {
//      return [];
//    }

//    String requestURL = _SERVICE_URL.replaceAll('%', Uri.encodeFull(recipe.link));
//    String json = await HttpRequest.getString(requestURL);
    String json = '{"name":"The Best Fresh Tomato Sauce Recipe","ingredients":[{"unit":"LB","type":"(4.5kg) ripe plum tomatoes, preferably mixed varieties (such as Romas, Amish Pastes, and San Marzanos), cut into large chunks, plus 15 pounds (6.8kg) ripe mixed tomatoes, mostly plums with a small portion of other tomatoes (such as beefsteaks), cut into large chunks","amount":10.0},{"unit":"TBSP","type":"(45ml) extra-virgin olive oil, plus more for greasing","amount":3.0},{"unit":"NULL","type":"large yellow onion, minced (see note)","amount":1.0},{"unit":"NULL","type":"medium cloves garlic, minced (see note)","amount":3.0},{"unit":"NULL","type":"large sprigs fresh basil","amount":2.0},{"unit":"NULL","type":"small tomato plant cutting with about 5 leaves (optional)","amount":1.0},{"unit":"NULL","type":"Kosher salt","amount":0.0}],"source":""}';

    var recipeIngredients = JSON.decode(json)['ingredients'];
    List<Ingredient> ingredients = recipeIngredients
        .map((rawData) => _parseIngredientFromJSON(rawData))
        .toList();
    return ingredients;
  }

  Ingredient _parseIngredientFromJSON(jsonObject) {
    String unit = jsonObject['unit'];
    if (unit == null || unit == 'NULL') {
      unit = '';
    }

    Ingredient ingredient = new Ingredient.withData(jsonObject['type'], jsonObject['amount'], unit);
    return ingredient;
  }
}