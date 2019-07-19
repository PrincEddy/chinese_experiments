import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:chinese_experiments/models/books.dart';
import 'package:chinese_experiments/models/chapters.dart';
import 'package:chinese_experiments/constants.dart';
import 'package:chinese_experiments/models/comprehension.dart';
import 'package:chinese_experiments/models/vocabulary.dart';
import 'package:chinese_experiments/models/confirmation.dart';

class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper.internal();

  factory DataBaseHelper() => instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  DataBaseHelper.internal();

//Initialising the dataBase;
  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'maindb.db');
    var myDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return myDB;
  }

  ///*****************************CREATING TABLES WHEN THE DATABASE IS INITIALIZED*********************************************

  void _onCreate(Database db, int newVersion) async {
    /// create and insert Table Confirmation
    await db.execute('''
      CREATE TABLE $conTable($conColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $conColumnIsConfirmed INTEGER)
    ''');
    await db.rawInsert('''
      INSERT INTO $conTable($conColumnIsConfirmed) VALUES(0);
    ''');

    /// Add table Books
    await db.execute('''
      CREATE TABLE $bTableBook($bColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
       $bColumnBookName VARCHAR(50) Not NULL,
       $bColumnProfilePic TEXT,
        $bColumnProgressCount  INTEGER)
        ''');

    ///Add table Chapters
    await db.execute('''
      CREATE TABLE $chTableChapters($chColumnChapterId INTEGER PRIMARY KEY AUTOINCREMENT,
      $chColumnChapterName VARCHAR(50) Not NULL,
       $chColumnChapterProgressCount INTEGER, $chColumnChapterIndex INTEGER,
        $chColumnBookId INTEGER,
        FOREIGN KEY($chColumnBookId) REFERENCES $bTableBook($bColumnId)
        ON UPDATE CASCADE
        ON DELETE CASCADE)
        ''');

    /// Add table Comprehension
    await db.execute('''
      CREATE TABLE $coTableComprehension($coColumnComprehensionId INTEGER PRIMARY KEY AUTOINCREMENT,
      $coColumnParagraph TEXT UNIQUE,
      $coColumnParagraphRead BOOLEAN,
      $coColumnComprehensionChapterId INTEGER,
      FOREIGN KEY($coColumnComprehensionChapterId) REFERENCES $chTableChapters($chColumnChapterId)
      ON UPDATE CASCADE
      ON DELETE CASCADE)   
    ''');

    ///Add table Vocabulary
    await db.execute('''
      CREATE TABLE $vTableVocabulary ( $vColumnVocabularyId INTEGER PRIMARY KEY AUTOINCREMENT,
      $vColumnCharacter TEXT NOT NUll,
      $vColumnPinyin TEXT UNIQUE,
      $vColumnMeaning TEXT,
      $vColumnCharacterRead INTEGER,
      $vColumnVocabularyChapterId INTEGER,
      FOREIGN KEY($vColumnVocabularyChapterId) REFERENCES $chTableChapters($chColumnChapterId)  
      ON UPDATE CASCADE
      ON DELETE CASCADE)
    
    ''');
  }

  ///*****************************CONFIRMATION QUERIES*********************************************
//  Future<int> getCount() async {
//    var dbClient = await db;
//
//    return Sqflite.firstIntValue(
//        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableUser'));
//  }
//
//  Future<int> deleteUser(int id) async {
//    var dbClient = await db;
//
//    return await dbClient
//        .delete(tableUser, where: '$columnId=?', whereArgs: [id]);
//  }
  ///*****************************CONFIRMATION QUERIES*********************************************
  Future<List> getConfirmation() async {
    var dbClient = await db;
    var res =
        await dbClient.rawQuery('''SELECT $conColumnIsConfirmed FROM $conTable
    ''');
    return res;
  }

  Future<int> updateConfirmation(Confirmation confirmation) async {
    var dbClient = await db;
    return await dbClient.update(conTable, confirmation.toMap(),
        where: '$conColumnId=?', whereArgs: [confirmation.id]);
  }

  ///*****************************BOOKS QUERIES*********************************************

//Add data to Books Table;

  Future<int> saveBook(Books book) async {
    var dbClient = await db;
    int res = await dbClient.insert('$bTableBook', book.toMap());
    return res;
  }

  // Get Books

  Future<List> getAllBooks() async {
    var dbClient = await db;
    var res = await dbClient.rawQuery('SELECT * FROM $bTableBook');
    return res;
  }

//Last added book
  Future getLastAddedBookID() async {
    var dbClient = await db;
    var res = await dbClient.rawQuery(
        'SELECT $bColumnId FROM $bTableBook ORDER BY $bColumnId DESC LIMIT 1');
    return res;
  }

  ///*****************************CHAPTERS QUERIES*********************************************

  // Add data to Chapter Table
  Future<int> saveChapter(Chapters chapter) async {
    var dbClient = await db;
    int res = await dbClient.insert('$chTableChapters', chapter.toMap());
    return res;
  }

  //Last added chapter
  Future getLastAddedChapterID() async {
    var dbClient = await db;
    var res = await dbClient.rawQuery(
        'SELECT $chColumnChapterId FROM $chTableChapters ORDER BY $chColumnChapterId DESC LIMIT 1');
    return res;
  }

  // Get All Chapters ;
  Future<List> getAllChapters(int id) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery(
      '''
         SELECT $chColumnChapterId,$chColumnChapterName,$chColumnChapterProgressCount,
          $chColumnChapterIndex FROM $chTableChapters JOIN $bTableBook WHERE  $chColumnBookId=$id AND $bColumnId=$id
      ''',
    );
    return res;
  }

  ///*****************************COMPREHENSION QUERIES*********************************************
  //Add data to Comprehension;

  Future<int> saveComprehension(Comprehension comprehension) async {
    var dbClient = await db;
    int res = await dbClient.insert(
        '$coTableComprehension', comprehension.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return res;
  }

  //Get All Comprehensions

  Future<List> getAllComprehensions(int id) async {
    var dbClient = await db;

    var res = await dbClient.rawQuery('''
    
      SELECT $coColumnParagraph,$coColumnParagraphRead,$coColumnComprehensionId
      FROM $coTableComprehension JOIN $chTableChapters WHERE  $coColumnComprehensionChapterId= $id AND $chColumnChapterId=$id

    
    ''');
    return res;
  }

  ///*****************************VOCABULARY QUERIES*********************************************

  //Add data to Vocabulary

  Future<int> saveVocabulary(Vocabulary vocabulary) async {
    var dbClient = await db;
    int res = await dbClient.insert('$vTableVocabulary', vocabulary.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return res;
  }

  // Get All Vocabulary

  Future<List> getAllVocabulary() async {
    var dbClient = await db;
    var res = await dbClient.rawQuery('''
    
    SELECT $vColumnCharacter,$vColumnPinyin
    FROM $vTableVocabulary
 
    ''');
    return res;
  }

  //Get selected chapter Vocabulary

  Future<List> getSelectedChapterVocabulary(int id) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery('''
    
    SELECT $vColumnCharacter,$vColumnPinyin,$vColumnMeaning,$vColumnCharacterRead,$vColumnVocabularyId
    FROM $vTableVocabulary JOIN $chTableChapters WHERE $vColumnVocabularyChapterId =$id AND $chColumnChapterId=$id
    
    ''');
    return res;
  }

  // Update Vocabulary
  Future<int> updateVocabulary(Vocabulary vocabulary) async {
    var dbClient = await db;
    return await dbClient.update(vTableVocabulary, vocabulary.toMap(),
        where: '$vColumnVocabularyId=?',
        whereArgs: [vocabulary.vocabularyId],
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // Delete Vocabulary

  //  Future<int> deleteUser(int id) async {
//    var dbClient = await db;
//
//    return await dbClient
//        .delete(tableUser, where: '$columnId=?', whereArgs: [id]);
//  }

  Future<int> deleteVocabulary(int id) async {
    var dbClient = await db;
    return await dbClient.delete(vTableVocabulary,
        where: '$vColumnVocabularyId=?', whereArgs: [id]);
  }

  ///*****************************CLOSE DATABASE*********************************************
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
