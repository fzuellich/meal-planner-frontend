import 'package:meal_planner_frontend/src/quick_edit/quick_edit_split_service.dart';
import "package:test/test.dart";

void main() {
  var service = new QuickEditSplitService();

  test("Splits 'information (subinformation)' into ['information', '(subinformation)']", () {
    var input = "information (subinformation)";
    expect(service.splitApart(input), equals(["information", "(subinformation)"]));
  });

  test("Can split 'information (sub information), (sub information)", () {
    var input = "information (sub information), (sub information)";
    expect(service.splitApart(input), equals(["information", "(sub information)", ",", "(sub information)"]));
  });
}