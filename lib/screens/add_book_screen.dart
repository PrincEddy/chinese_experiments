import 'package:flutter/material.dart';
import 'package:chinese_experiments/utils/data_base_helper.dart';
import 'package:chinese_experiments/models/books.dart';

String bookValue = '';

class AddBookScreen extends StatefulWidget {
//  static const String id = 'add_book_screen';

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  var db = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Book'),
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
          AddBookCard(
            onChanged: (text) {
              bookValue = text;
            },
            onPressed: () async {
              if (bookValue != '') {
                await db.saveBook(Books(bookValue, 0));
                bookValue = '';
                Navigator.pop(context, 'Done');
              } else {
                Navigator.pop(context, 'nothing ADDED');
              }
            },
          ),
        ],
      ),
    );
  }
}

class AddBookCard extends StatelessWidget {
  AddBookCard({@required this.onChanged, @required this.onPressed});

  final Function onChanged;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF130f40),
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 70.0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  shape: CircleBorder(),
                  color: Colors.white,
                  onPressed: () {},
                  child: Icon(
                    Icons.edit,
                    size: 30.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Book Name',
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
