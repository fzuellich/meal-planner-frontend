import 'package:angular2/angular2.dart';
import 'package:meal_planner_frontend/src/common/ingredient.dart';

@Component(
  selector: 'shopping-list',
  styleUrls: const ['shopping_list.css'],
  templateUrl: 'shopping_list.html',
  directives: const [NgIf, NgFor],
)
class ShoppingListComponent {

  @Input()
  List<Ingredient> ingredients;

}