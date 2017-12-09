import 'package:meal_planner_frontend/src/common/ingredient.dart';

class Recipe {
  String _id;

  String _name;

  String _description;

  String _link;

  List<Ingredient> _ingredients;

  Recipe.withData(this._id, this._name, this._description, this._link, this._ingredients);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  set name(String value) {
    _name = value;
  }

  String get link => _link;

  set link(String value) {
    _link = value;
  }

  List<Ingredient> get ingredients => _ingredients;

  set ingredients(List<Ingredient> value) {
    _ingredients = value;
  }


}
