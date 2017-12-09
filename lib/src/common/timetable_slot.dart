import 'package:intl/intl.dart';
import 'recipe.dart';

/**
 * Represent one slot in a time table.
 */
class TimetableSlot {

  final DateFormat SLOT_DATE_FORMAT = new DateFormat("E, d.m.Y");

  DateTime date;
  Recipe recipe;

  TimetableSlot(this.date, this.recipe);

}