import 'package:chinese_experiments/constants.dart';

class Confirmation {
  int _id;
  int _isConfirmed;

  Confirmation(this._isConfirmed);

  Confirmation.map(obj) {
    this._id = obj[conColumnId];
    this._isConfirmed = obj[conColumnIsConfirmed];
  }

  int get id => _id;
  int get isConfirmed => _isConfirmed;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[conColumnId] = id;
    map[conColumnIsConfirmed] = isConfirmed;

    return map;
  }

  Confirmation.fromMap(Map<String, dynamic> map) {
    this._id = map[conColumnId];
    this._isConfirmed = map[conColumnIsConfirmed];
  }
}
