import 'package:chinese_experiments/constants.dart';

class Chapters {
  String _chapterName;
  int _id;
  int _progressCount;
  int _chapterIndex;
  int _bookId;

  Chapters(this._chapterName, this._progressCount, this._bookId);

  Chapters.map(dynamic obj) {
    this._chapterName = obj[chColumnChapterName];
    this._id = obj[chColumnChapterId];
    this._progressCount = obj[chColumnChapterProgressCount];
    this._chapterIndex = obj[chColumnChapterIndex];
    this._bookId = obj[chColumnBookId];
  }

  String get chapterName => _chapterName;
  int get id => _id;
  int get progressCount => _progressCount;
  int get chapterIndex => _chapterIndex;
  int get bookId => _bookId;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[chColumnChapterName] = chapterName;
    map[chColumnChapterId] = id;
    map[chColumnChapterProgressCount] = progressCount;
    map[chColumnChapterIndex] = chapterIndex;
    map[chColumnBookId] = bookId;

    return map;
  }

  Chapters.fromMap(Map<String, dynamic> map) {
    this._chapterName = map[chColumnChapterName];
    this._id = map[chColumnChapterId];
    this._progressCount = map[chColumnChapterProgressCount];
    this._chapterIndex = map[chColumnChapterIndex];
    this._bookId = map[chColumnBookId];
  }
}
