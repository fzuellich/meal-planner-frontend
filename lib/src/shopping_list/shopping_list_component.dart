import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart' show formDirectives;
import 'package:meal_planner_frontend/src/common/shoppping_list_item.dart';
import 'package:meal_planner_frontend/src/quick_edit/quick_edit_component.dart';

@Component(
  selector: 'shopping-list',
  styleUrls: const ['shopping_list.css'],
  templateUrl: 'shopping_list.html',
  directives: const [NgIf, NgFor, formDirectives, QuickEditComponent],
)
class ShoppingListComponent {

  @Input()
  List<ShoppingListItem> shoppingListItems;

  ShoppingListItem editableItem;

  ShoppingListItem quickEditItem;

  void removeItem(ShoppingListItem item) {
    shoppingListItems.remove(item);
  }

  void onDoubleClick(ShoppingListItem item) {
    editableItem = item;
  }

  void onItemEdited() {
    editableItem = null;
  }

  void renderQuickEdit(ShoppingListItem item) {
    quickEditItem = item;
  }
}