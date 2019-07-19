import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'add_chapter_screen.dart';
import 'package:chinese_experiments/models/chapters.dart';
import 'package:chinese_experiments/models/chinese_data.dart';
import 'chapter_contents_screen.dart';

class ChapterScreen extends StatefulWidget {
  ChapterScreen({@required this.bookId, @required this.bookName});
  final int bookId;
  final String bookName;
  @override
  _ChapterScreenState createState() =>
      _ChapterScreenState(bookId: bookId, bookName: bookName);
}

class _ChapterScreenState extends State<ChapterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    chapters = [];
  }

  _ChapterScreenState({@required this.bookId, @required this.bookName});
  final int bookId;
  final bookName;

  Widget makeChapters() {
    getChapters(bookId);
    List<Widget> chaptersList = [];
    if (chapters != null && chapters.length != 0) {
      for (int i = 0; i < chapters.length; i++) {
        Chapters chapter = Chapters.map(chapters[i]);
        chaptersList.add(ChapterContainerCard(
          onTap: () async {
            await getVocabulary(chapter.id);
            await getComprehensions(chapter.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChapterContentsScreen(
                      chapterId: chapter.id,
                      chapterName: chapter.chapterName,
                    ),
              ),
            );
          },
          chapterName: chapter.chapterName,
          index: i + 1,
          percent: chapter.progressCount,
        ));
        chaptersList.add(Divider(
          height: 2.0,
        ));
      }
    } else {
      chaptersList.add(Center(
        child: Text(
          'Press the add button to add New Chapter',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
          ),
        ),
      ));
    }

    return ListView.builder(
      itemCount: chaptersList.length,
      itemBuilder: (BuildContext chapters, int index) {
        return chaptersList[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bookName,
          style: TextStyle(
            fontSize: 26.0,
            color: Colors.white,
          ),
        ),
      ),
      body: makeChapters(),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddChapterScreen(
                              bookId: bookId,
                            )));
                await getChapters(bookId);

                if (result != null) {
                  setState(() {
                    getChapters(bookId);
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

class ChapterContainerCard extends StatelessWidget {
  ChapterContainerCard(
      {@required this.chapterName,
      @required this.percent,
      @required this.index,
      @required this.onTap});
  final String chapterName;
  final int percent;
  final int index;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Color(0xFF130f40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                child: Text(
                  '$index',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Text(
              chapterName,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularPercentIndicator(
                progressColor: Colors.blueAccent,
                percent: (percent / 100).floorToDouble(),
                radius: 80,
                backgroundColor: Colors.white,
                lineWidth: 7.0,
                center: Text(
                  '$percent%',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
