import 'dart:async';
import 'package:angular/angular.dart';

import 'package:meal_planner_frontend/src/common/recipe.dart';
import 'package:meal_planner_frontend/src/common/recipe_name_pipe.dart';
import 'package:meal_planner_frontend/src/common/recipe_service.dart';

@Component(
    selector: 'recipe-selection',
    templateUrl: 'recipe_selection.html',
    styleUrls: const ['recipe_selection.css'],
    directives: const [NgFor, NgIf],
    pipes: const [ReplacePipe, RecipeNamePipe],
    providers: const [RecipeService])

class RecipeSelectionComponent {

  @Input()
  List<Recipe> recipes;

  final _recipeRemovedEvent = new StreamController<Recipe>();

  @Output()
  Stream<Recipe> get recipeRemoved => _recipeRemovedEvent.stream;

  void removeRecipeFromSelection(recipe) {
    _recipeRemovedEvent.add(recipe);
  }

}
