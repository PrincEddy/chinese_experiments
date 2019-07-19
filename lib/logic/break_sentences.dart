import 'package:lpinyin/lpinyin.dart';

bool isNumeric(String foo) {
  bool checkIfNumeric;
  try {
    var foo1 = double.parse(foo);
    if (foo1 is double) {
      checkIfNumeric = true;
    }
  } catch (e) {
    checkIfNumeric = false;
  }
  return checkIfNumeric;
}

Map<String, String> convertToList(String s) {
  List characterList = [];
  characterList = List<String>.from(s.split(''));
  characterList.removeWhere((value) => value == ' ');
  for (int i = 0; i < characterList.length; i++) {}
  Map<String, String> charactersPinyin = {};
  for (var i in characterList) {
    if (i == '?' ||
        i == '？' ||
        i == '!' ||
        i == '”' ||
        i == '“' ||
        i == ':' ||
        i == ',' ||
        i == '(' ||
        i == ')' ||
        i == '。' ||
        i == ';' ||
        i == '\n' ||
        isNumeric(i)) {
    } else {
      charactersPinyin[i] = PinyinHelper.getPinyin(i,
          separator: '', format: PinyinFormat.WITH_TONE_MARK);
    }
  }
  return charactersPinyin;
}
