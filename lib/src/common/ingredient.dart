class Ingredient {
  String _name;

  Ingredient.withData(this._name);

  String get name => _name;

  set name(String value) {
    _name = value;
  }


}