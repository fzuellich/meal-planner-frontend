import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart' show formDirectives;
import 'package:meal_planner_frontend/src/common/shoppping_list_item.dart';

@Component(
  selector: 'quick-edit',
  templateUrl: 'quick_edit.html',
  directives: const [NgIf, NgFor, formDirectives],
)
class QuickEditComponent implements OnInit {

  @Input()
  ShoppingListItem shoppingItem;

  void ngOnInit() {
    List<String> something = _splitApart("hello world (optional)");
    print(something);
    assert(something == ["hello world", "(optional)"]);

    something = _splitApart("1 0x LB (4.5KG) ripe plum tomatoes (such as Romas, Amish pastes, and San Marzanos), not important");
    print(something);
    assert(something == ["1 0x LB", "(4.5KG) ripe plum tomatoes", "(such as Romas, Amish pastes, and San Marzanos)", ", not important"]);
  }

  List<String> _splitApart(String input) {
    int indexOfOpeningBracket = input.indexOf('(');
    int indexOfClosingBracket = input.indexOf(')');

    bool hasOpeningBracket = indexOfOpeningBracket != -1;
    bool hasClosingBracket = indexOfClosingBracket != -1;

    if (!hasOpeningBracket || !hasClosingBracket) {
      return [input];
    }

    List<String> result = new List();
    result.add(input.substring(0, indexOfOpeningBracket));
    result.add(input.substring(indexOfOpeningBracket, indexOfClosingBracket + 1));

    if (input.substring(indexOfClosingBracket + 1).isNotEmpty) {
      result.add(input.substring(indexOfClosingBracket + 1));
    }

    return result;
  }

}
