class Recipe {
  String _id;

  String _name;

  String _description;

  Recipe.withData(this._id, this._name, this._description);

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


}