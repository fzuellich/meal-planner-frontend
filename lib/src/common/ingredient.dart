class Ingredient {

  String _name;

  double _amount;

  String _unit;

  Ingredient.withData(this._name, this._amount, this._unit);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  double get amount => _amount;

  set amount(double value) {
    _amount = value;
  }

  String get unit => _unit;

  set unit(String value) {
    _unit = value;
  }

}