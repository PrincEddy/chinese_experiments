import 'package:flutter/material.dart';

List<String> titles = ['Notes', 'Home', 'Quiz', 'Settings'];
List<IconData> bottomIcons = [
  Icons.note,
  Icons.home,
  Icons.question_answer,
  Icons.settings
];
bool isActive = true;
Map<String, IconData> navBar = {
  titles[0]: Icons.note,
  titles[1]: Icons.home,
  titles[2]: Icons.question_answer,
  titles[3]: Icons.settings,
};

int selectedIndex = 1;

class BottomNavigationCard extends StatefulWidget {
  BottomNavigationCard({@required this.onTap});
  final Function onTap;

  @override
  _BottomNavigationCardState createState() => _BottomNavigationCardState();
}

class _BottomNavigationCardState extends State<BottomNavigationCard> {
  bool isSelected = true;
  List<BottomNavigationBarItem> makeBottomNavigator() {
    List<BottomNavigationBarItem> bottomNavigatorItems = [];

    for (int i = 0; i < 4; i++) {
      bottomNavigatorItems.add(
        BottomNavigationBarItem(
          icon: Icon(
            bottomIcons[i],
            size: 30.0,
            color: Colors.white,
          ),
          activeIcon: Icon(
            bottomIcons[i],
            size: 30.0,
            color: Colors.blue,
          ),
          title: Text(
            titles[i],
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.white,
            ),
          ),
        ),
      );
    }

    return bottomNavigatorItems;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: widget.onTap,
      type: BottomNavigationBarType.fixed,
      items: makeBottomNavigator(),
      currentIndex: selectedIndex,
      fixedColor: Colors.white,
    );
  }
}
