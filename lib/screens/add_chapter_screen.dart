import 'package:flutter/material.dart';
import 'package:chinese_experiments/utils/data_base_helper.dart';
import 'package:chinese_experiments/models/chapters.dart';

String nameValue = '';

class AddChapterScreen extends StatefulWidget {
  AddChapterScreen({@required this.bookId});

  final int bookId;
  @override
  _AddChapterScreenState createState() =>
      _AddChapterScreenState(bookId: bookId);
}

class _AddChapterScreenState extends State<AddChapterScreen> {
  _AddChapterScreenState({@required this.bookId});
  final int bookId;
  var db = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Chapter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          AddChapterCard(
            onPressed: () async {
              if (nameValue != '') {
                await db.saveChapter(Chapters(nameValue, 0, bookId));
                nameValue = '';
                Navigator.pop(context, 'added Chapter');
              } else {
                Navigator.pop(context, 'Nothing Added');
              }
            },
            onChanged: (text) {
              nameValue = text;
            },
          ),
        ],
      ),
    );
  }
}

class AddChapterCard extends StatelessWidget {
  AddChapterCard({@required this.onPressed, @required this.onChanged});

  final Function onPressed;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 50.0),
      color: Color(0xFF130f40),
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Add Chapter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Chapter Name',
                ),
                onChanged: onChanged,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: CircleBorder(),
                    onPressed: onPressed,
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 70.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
