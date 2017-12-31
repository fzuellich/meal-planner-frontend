import 'package:angular2/angular2.dart';
import 'package:meal_planner_frontend/src/common/recipe.dart';

/*
 * Takes a recipe object and tries to conceive a meaningful name from the available
 * properties.
 *
 * Usage:
 *  recipe | recipeName:format
 *
 * Example:
 *  recipe | recipeName:long -> Some recipe name (http://.../some-recipe-name.html)
 */
@Pipe("recipeName")
class RecipeNamePipe extends PipeTransform {

  String transform(Recipe input, String format) {
    if (input == null) {
      return 'Untitled Recipe';
    }

    switch (format) {
      case 'long':
        return _getLongRecipeName(input);
      case 'short':
      default:
        return _getShortRecipeName(input);
    }
  }

  String _getLongRecipeName(Recipe recipe) {
    String result = 'Untitled Recipe';

    if (recipe.name != null && recipe.name.isNotEmpty) {
      result = recipe.name;
    }

    if ((recipe.name != null && recipe.name.isEmpty)
        && (recipe.link != null && recipe.link.isNotEmpty)) {
      Uri uri = Uri.parse(recipe.link);
      print(uri);

      String abbreviatedPath = uri.path.substring(uri.path.length - 30);

      String sanitizedLink = uri.host + '/...' + abbreviatedPath;
      result += ' (${sanitizedLink})';
    }

    return result;
  }

  String _getShortRecipeName(Recipe recipe) {
    if (recipe.name == null || recipe.name.isEmpty) {
      return 'Untitled recipe';
    } else {
      return recipe.name;
    }
  }
}