import 'package:angular2/angular2.dart';
import 'package:meal_planner_frontend/src/common/ingredient_retrieval_status.dart';
import 'package:meal_planner_frontend/src/common/recipe_name_pipe.dart';

@Component(
  selector: 'shopping-list-status',
  styleUrls: const ['shopping_list_status.css'],
  templateUrl: 'shopping_list_status.html',
  directives: const [NgIf, NgFor],
  pipes: const [ReplacePipe, RecipeNamePipe]
)
class ShoppingListStatusComponent {

  @Input()
  List<IngredientRetrievalStatus> status;

}
