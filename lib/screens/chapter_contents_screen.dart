import 'package:flutter/material.dart';
import 'comprehension_screen.dart';
import 'package:chinese_experiments/models/chinese_data.dart';
import 'vocabulary_screen.dart';

class ChapterContentsScreen extends StatefulWidget {
  ChapterContentsScreen({@required this.chapterId, @required this.chapterName});
  final int chapterId;
  final String chapterName;

  @override
  _ChapterContentsScreenState createState() => _ChapterContentsScreenState(
      chapterId: chapterId, chapterName: chapterName);
}

class _ChapterContentsScreenState extends State<ChapterContentsScreen> {
  @override
  void dispose() {
    super.dispose();
    comprehension = [];
    vocabulary = [];
  }

  _ChapterContentsScreenState(
      {@required this.chapterId, @required this.chapterName});

  final int chapterId;
  final String chapterName;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              chapterName,
              style: TextStyle(
                fontSize: 26.0,
                color: Colors.white,
              ),
            ),
            bottom: TabBar(tabs: <Widget>[
              Tab(
                text: 'Comprehension',
              ),
              Tab(
                text: 'Vocabulary',
              ),
            ]),
          ),
          body: TabBarView(children: <Widget>[
            ComprehensionScreen(chapterId: chapterId),
            VocabularyScreen(
              chapterId: chapterId,
            ),
          ])),
    );
  }
}
