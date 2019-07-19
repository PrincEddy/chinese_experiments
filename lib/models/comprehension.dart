import 'package:chinese_experiments/constants.dart';

class Comprehension {
  String _paragraph;
  int _comprehensionId;
  int _paragraphRead;
  int _comprehensionChapterId;

  Comprehension(
      this._paragraph, this._paragraphRead, this._comprehensionChapterId);

  Comprehension.map(dynamic obj) {
    this._paragraph = obj[coColumnParagraph];
    this._comprehensionId = obj[coColumnComprehensionId];
    this._paragraphRead = obj[coColumnParagraphRead];
    this._comprehensionChapterId = obj[coColumnComprehensionChapterId];
  }

  String get paragraph => _paragraph;
  int get comprehensionId => _comprehensionId;
  int get paragraphRead => _paragraphRead;
  int get comprehensionChapterId => _comprehensionChapterId;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[coColumnParagraph] = paragraph;
    map[coColumnComprehensionId] = comprehensionId;
    map[coColumnParagraphRead] = paragraphRead;
    map[coColumnComprehensionChapterId] = comprehensionChapterId;
    return map;
  }

  Comprehension.fromMap(Map<String, dynamic> map) {
    this._paragraph = map[coColumnParagraph];
    this._comprehensionId = map[coColumnComprehensionId];
    this._paragraphRead = map[coColumnParagraphRead];
    this._comprehensionChapterId = map[coColumnComprehensionChapterId];
  }
}
