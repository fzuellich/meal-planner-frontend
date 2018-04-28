import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart' show formDirectives;
import 'package:meal_planner_frontend/src/common/shoppping_list_item.dart';
import 'package:meal_planner_frontend/src/quick_edit/quick_edit_split_service.dart';

@Component(
  selector: 'quick-edit',
  styleUrls: const ['quick_edit.css'],
  templateUrl: 'quick_edit.html',
  directives: const [NgIf, NgFor, formDirectives],
  providers: const [QuickEditSplitService]
)
class QuickEditComponent implements OnInit {

  @Input()
  ShoppingListItem shoppingItem;

  QuickEditSplitService _splitService;

  List<String> parts;

  QuickEditComponent(this._splitService);

  void ngOnInit() {
    parts = _splitService.splitApart(shoppingItem.value);
  }

  void removePart(index) {
    parts.removeAt(index);
  }

  void save() {
    shoppingItem.value = parts.join();
  }
}
