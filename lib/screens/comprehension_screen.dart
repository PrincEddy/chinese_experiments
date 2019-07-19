import 'package:flutter/material.dart';
import 'add_comprehension_screen.dart';
import 'package:chinese_experiments/models/chinese_data.dart';
import 'package:chinese_experiments/models/comprehension.dart';

class ComprehensionScreen extends StatefulWidget {
  ComprehensionScreen({@required this.chapterId});

  final int chapterId;

  @override
  _ComprehensionScreenState createState() =>
      _ComprehensionScreenState(chapterId: chapterId);
}

class _ComprehensionScreenState extends State<ComprehensionScreen> {
  _ComprehensionScreenState({@required this.chapterId});
  final int chapterId;

  Widget makeParagraphCards() {
    getComprehensions(chapterId);
    List<Widget> paragraphCardList = [];

    if (comprehension != null && comprehension.length != 0) {
      for (var i in comprehension) {
        Comprehension paragraphs = Comprehension.map(i);
        paragraphCardList
            .add(ParagraphCard(paragraphText: paragraphs.paragraph));
        paragraphCardList.add(Divider(
          height: 2.0,
          color: Colors.blue,
        ));
      }
    } else {
      paragraphCardList.add(Center(
        child: Text(
          'Press the add button to add New Paragraph',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
          ),
        ),
      ));
    }
    return ListView.builder(
      itemCount: paragraphCardList.length,
      itemBuilder: (BuildContext paragraphs, int index) {
        return paragraphCardList[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: makeParagraphCards(),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
              onPressed: () async {
                setState(() {
                  getComprehensions(chapterId);
                });
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddComprehensionScreen(
                              chapterId: chapterId,
                            )));

                if (result != null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('$result'),
                    duration: Duration(milliseconds: 500),
                  ));
                }
              },
              child: Icon(
                Icons.add,
                size: 30.0,
              ),
            ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ParagraphCard extends StatelessWidget {
  ParagraphCard({@required this.paragraphText});

  final String paragraphText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(),
              Icon(
                Icons.volume_down,
                size: 30.0,
                color: Colors.blue,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              paragraphText,
              style: TextStyle(fontSize: 18.0, letterSpacing: 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
