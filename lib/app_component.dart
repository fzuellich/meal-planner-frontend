import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';

import 'package:meal_planner_frontend/src/common/board.dart';
import 'package:meal_planner_frontend/src/recipe_browser/recipe_browser_component.dart';
import 'src/board_browser/board_browser_component.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [NgIf, materialDirectives, BoardBrowserComponent, RecipeBrowserComponent],
  providers: const [materialProviders],
)
class AppComponent {

  Board selectedBoard = null;

}
