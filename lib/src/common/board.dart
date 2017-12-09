class Board {

  String _id;
  String _name;
  String _description;
  String _status = 'default';

  Board();

  Board.withData(this._id, this._name, this._description);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }


}