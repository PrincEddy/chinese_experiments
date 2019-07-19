import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'bottom_navigation_bars.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> bottomNavigationBars = [
      Container(),
      HomeScreen(),
      QuizScreen(),
      Container(),
    ];
    return Scaffold(
      body: bottomNavigationBars.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationCard(
        onTap: (int item) {
          setState(() {
            selectedIndex = item;
          });
        },
      ),
    );
  }
}
