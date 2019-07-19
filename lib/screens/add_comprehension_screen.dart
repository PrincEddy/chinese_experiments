import 'package:flutter/material.dart';
import 'package:chinese_experiments/utils/data_base_helper.dart';
import 'package:chinese_experiments/models/comprehension.dart';
import 'package:chinese_experiments/logic/break_sentences.dart';
import 'package:chinese_experiments/models/vocabulary.dart';

String paragraphValue = '';

class AddComprehensionScreen extends StatefulWidget {
  AddComprehensionScreen({@required this.chapterId});
  final int chapterId;

  @override
  _AddComprehensionScreenState createState() =>
      _AddComprehensionScreenState(chapterId: chapterId);
}

class _AddComprehensionScreenState extends State<AddComprehensionScreen> {
  _AddComprehensionScreenState({@required this.chapterId});

  final int chapterId;

  var db = DataBaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Paragraph'),
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
          AddParagraphCard(
            onChanged: (text) {
              paragraphValue = text;
            },
            onPressed: () async {
              if (paragraphValue != '') {
                int check = await db.saveComprehension(
                    Comprehension(paragraphValue, 0, chapterId));
                Map<String, String> charactersPinyinMap =
                    convertToList(paragraphValue);
                for (var i in charactersPinyinMap.keys) {
                  await db.saveVocabulary(
                      Vocabulary(i, charactersPinyinMap[i], 0, chapterId));
                }
                if (check == null) {
                  Navigator.pop(context, 'Allready Exist!!');
                } else {
                  Navigator.pop(context, 'Paragraph added');
                }

                paragraphValue = '';
              } else {
                Navigator.pop(context, 'Error!');
              }
            },
          ),
        ],
      ),
    );
  }
}

class AddParagraphCard extends StatelessWidget {
  AddParagraphCard({@required this.onChanged, @required this.onPressed});
  final Function onChanged;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF0a0d22),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'New paragraph',
                  border: OutlineInputBorder(),
                  fillColor: Color(0xFF17202a),
                ),
                onChanged: onChanged,
                textAlign: TextAlign.center,
                maxLines: 10,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: RaisedButton(
                shape: CircleBorder(),
                onPressed: onPressed,
                child: Icon(
                  Icons.done_all,
                  color: Colors.white,
                  size: 70.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
