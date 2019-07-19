import 'package:chinese_experiments/constants.dart';

class Books {
  String _bookName;
  String _profilePic;
  int _id;
  int _progressCount;
  Books(this._bookName, this._progressCount);

  Books.map(dynamic obj) {
    this._bookName = obj[bColumnBookName];
    this._profilePic = obj[bColumnProfilePic];
    this._id = obj[bColumnId];
    this._progressCount = obj[bColumnProgressCount];
  }

  String get bookName => _bookName;
  String get profilePic => _profilePic;
  int get id => _id;
  int get progressCount => _progressCount;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[bColumnBookName] = bookName;
    map[bColumnProfilePic] = profilePic;
    map[bColumnId] = id;
    map[bColumnProgressCount] = progressCount;

    return map;
  }

  Books.fromMap(Map<String, dynamic> map) {
    this._bookName = map[bColumnBookName];
    this._profilePic = map[bColumnProfilePic];
    this._id = map[bColumnId];
    this._progressCount = map[bColumnProgressCount];
  }
}
