import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'add_book_screen.dart';
import 'package:chinese_experiments/models/books.dart';
import 'package:chinese_experiments/models/chinese_data.dart';

import 'chapter_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GridView makeBookCards() {
    List<Widget> bookCards = [];
    if (books != null && books.length != 0) {
      for (var i in books) {
        Books book = Books.map(i);

        bookCards.add(BookCard(
          onTap: () async {
            await getChapters(book.id);
            setState(() {
              getChapters(book.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChapterScreen(
                          bookId: book.id,
                          bookName: book.bookName,
                        )),
              );
            });
          },
          name: book.bookName,
          percent: book.progressCount,
          bookId: book.id,
        ));
      }
    } else {
      bookCards.add(
        Center(
          child: Text(
            'Press the add button to add New Book',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      children: bookCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 26.0,
            color: Colors.white,
          ),
        ),
      ),
      body: makeBookCards(),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddBookScreen()));
                await getBooks();
                if (result != null) {
                  setState(() {
                    getBooks();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('$result'),
                      duration: Duration(milliseconds: 500),
                    ));
                  });
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

class BookCard extends StatelessWidget {
  BookCard(
      {@required this.name,
      @required this.percent,
      @required this.bookId,
      @required this.onTap});
  final String name;
  final int percent;
  final int bookId;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(5.0),
        color: Color(0xFF130f40),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 60.0,
//                backgroundImage: AssetImage('images/book1.jpg'),
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearPercentIndicator(
                lineHeight: 12.0,
                backgroundColor: Colors.white,
                percent: (percent / 100).floorToDouble(),
                progressColor: Colors.blueAccent,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
