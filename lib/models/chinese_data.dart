/// BOOK 1
import 'package:chinese_experiments/utils/data_base_helper.dart';
import 'books.dart';
import 'chapters.dart';
import 'package:chinese_experiments/constants.dart';
import 'package:chinese_experiments/data_modeling.dart';
import 'vocabulary.dart';
import 'comprehension.dart';
import 'package:chinese_experiments/logic/break_sentences.dart';
import 'package:chinese_experiments/models/confirmation.dart';

var db = DataBaseHelper();

List books = [];

Future<List> getBooks() async {
  books = await db.getAllBooks();
  return books;
}

List chapters = [];
List chapterIDs = [];
Future<List> getChapters(int id) async {
  chapters = await db.getAllChapters(id);
  return chapters;
}

List comprehension = [];
getComprehensions(int id) async {
  comprehension = await db.getAllComprehensions(id);
}

List vocabulary = [];
getVocabulary(int id) async {
  vocabulary = await db.getSelectedChapterVocabulary(id);
}

List allVocabulary = [];
getAllVocabularyInDatabase() async {
  allVocabulary = await db.getAllVocabulary();
}

deleteSelectedVocabulary(List<dynamic> selectedVocabulary) async {
  if (selectedVocabulary != null && selectedVocabulary.length != 0) {
    for (var i in selectedVocabulary) {
      await db.deleteVocabulary(i);
    }
  }
}

class SaveData {
  saveAllBooks() async {
    var confirmation = await db.getConfirmation();
    if (confirmation[0][conColumnIsConfirmed] == 0) {
      for (var i in bookNames) {
        await db.saveBook(Books(i, 0));
        var theID = await db.getLastAddedBookID();
        await saveAllChapters(await theID[0][bColumnId]);
      }

      var confirmed =
          Confirmation.fromMap({conColumnId: 1, conColumnIsConfirmed: 1});

      await db.updateConfirmation(confirmed);
    } else {
      return;
    }
  }

  saveAllChapters(var bookId) async {
    String k = allData.keys.elementAt(bookId - 1);
    for (var j in allData[k].keys) {
      await db.saveChapter(Chapters(j, 0, bookId));
      var currentChapterID = await db.getLastAddedChapterID();
      var x = allData[k][j];
      await saveAllComprehension(x, currentChapterID[0][chColumnChapterId]);
    }
  }

  saveAllComprehension(var comprehension, var chapterId) async {
    for (var comp in comprehension) {
      await db.saveComprehension(Comprehension(comp, 0, chapterId));
      Map<String, String> charactersPinyinMap = convertToList(comp);
      for (var character in charactersPinyinMap.keys) {
        await db.saveVocabulary(Vocabulary(
            character, charactersPinyinMap[character], 0, chapterId));
      }
    }
  }
}
