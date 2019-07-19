import 'package:flutter/material.dart';
import 'models/chinese_data.dart';
import 'screens/bottom_navigation_screen.dart';

void main() async {
  SaveData saveData = SaveData();
  await saveData.saveAllBooks();
  await getAllVocabularyInDatabase();
  await getBooks();
  runApp(MaterialApp(
    theme: ThemeData.dark().copyWith(
      primaryColor: Color(0xFF1c2833),
      scaffoldBackgroundColor: Color(0xFF1c2833),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: BottomNavigationScreen(),
  ));
}
