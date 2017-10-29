import 'timetable_slot.dart';
import 'recipe.dart';
import 'mock_ingredient.dart';

final DateTime today = new DateTime.now();

DateTime createDateTime(int daysAfterToday) {
  return today.add(new Duration(days: daysAfterToday));
}

final List<TimetableSlot> mockTimetableSlots = [
  new TimetableSlot(today, new Recipe.withData("1", "Recipe 01", "", listOfMockIngredients)),
  new TimetableSlot(createDateTime(1), new Recipe.withData("2", "Recipe 02", "", listOfMockIngredients)),
  new TimetableSlot(createDateTime(2), new Recipe.withData("3", "Recipe 03", "", listOfMockIngredients)),
  new TimetableSlot(createDateTime(3), new Recipe.withData("4", "Recipe 04", "", listOfMockIngredients)),
  new TimetableSlot(createDateTime(4), new Recipe.withData("5", "Recipe 05", "", listOfMockIngredients)),
  new TimetableSlot(createDateTime(5), new Recipe.withData("6", "Recipe 06", "", listOfMockIngredients)),
  new TimetableSlot(createDateTime(6), new Recipe.withData("7", "Recipe 07", "", listOfMockIngredients)),
];
