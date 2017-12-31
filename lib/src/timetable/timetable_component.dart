import 'package:angular2/angular2.dart';

import '../common/timetable_slot.dart';
import 'package:meal_planner_frontend/src/common/recipe_name_pipe.dart';

@Component(
  selector: 'timetable',
  templateUrl: 'timetable_component.html',
  styleUrls: const ['timetable_component.css'],
  pipes: const [COMMON_PIPES, RecipeNamePipe],
  directives: const [NgFor, NgIf])

class TimetableComponent {

  @Input()
  List<TimetableSlot> timetableSlots = [new TimetableSlot(new DateTime.now(), null)];//mockTimetableSlots;

  static String DROPZONE_SELECTOR = '.timetable--slot';

}

