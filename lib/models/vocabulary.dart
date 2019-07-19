import 'package:chinese_experiments/constants.dart';

class Vocabulary {
  int _vocabularyId;
  int _vocabularyChapterId;
  String _character;
  String _pinyin;
  String _meaning;
  int _characterRead;

  Vocabulary(this._character, this._pinyin, this._characterRead,
      this._vocabularyChapterId);

  Vocabulary.map(obj) {
    this._vocabularyId = obj[vColumnVocabularyId];
    this._vocabularyChapterId = obj[vColumnVocabularyChapterId];
    this._character = obj[vColumnCharacter];
    this._pinyin = obj[vColumnPinyin];
    this._meaning = obj[vColumnMeaning];
    this._characterRead = obj[vColumnCharacterRead];
  }

  int get vocabularyId => _vocabularyId;
  int get vocabularyChapterId => _vocabularyChapterId;
  String get character => _character;
  String get pinyin => _pinyin;
  String get meaning => _meaning;
  int get characterRead => _characterRead;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[vColumnVocabularyId] = vocabularyId;
    map[vColumnVocabularyChapterId] = vocabularyChapterId;
    map[vColumnCharacter] = character;
    map[vColumnPinyin] = pinyin;
    map[vColumnMeaning] = meaning;
    map[vColumnCharacterRead] = characterRead;

    return map;
  }

  Vocabulary.fromMap(Map<String, dynamic> map) {
    this._vocabularyId = map[vColumnVocabularyId];
    this._vocabularyChapterId = map[vColumnVocabularyChapterId];
    this._character = map[vColumnCharacter];
    this._pinyin = map[vColumnPinyin];
    this._meaning = map[vColumnMeaning];
    this._characterRead = map[vColumnCharacterRead];
  }
}
