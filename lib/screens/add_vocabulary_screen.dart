import 'package:flutter/material.dart';
import 'package:chinese_experiments/utils/data_base_helper.dart';
import 'package:chinese_experiments/models/vocabulary.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:chinese_experiments/constants.dart';
import 'package:chinese_experiments/models/chinese_data.dart';

String characterValue = '';

class AddVocabularyScreen extends StatefulWidget {
  AddVocabularyScreen(
      {@required this.chapterId, this.characterName, this.vocabularyId});

  final int chapterId;
  final String characterName;
  final int vocabularyId;

  @override
  _AddVocabularyScreenState createState() => _AddVocabularyScreenState();
}

class _AddVocabularyScreenState extends State<AddVocabularyScreen> {
  var db = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    TextEditingController characterTobeEdited = TextEditingController(
        text: widget.characterName == null ? '' : widget.characterName);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Character'),
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
          AddVocabularyCard(
            characterTobeEdited: characterTobeEdited,
            onChanged: (text) {
              characterValue = text;
            },
            onPressed: () async {
              if (characterValue != '' && widget.characterName == null) {
                String pinyinValue = PinyinHelper.getPinyin(characterValue,
                    format: PinyinFormat.WITH_TONE_MARK);

                int check = await db.saveVocabulary(Vocabulary(
                    characterValue, pinyinValue, 0, widget.chapterId));
                characterValue = '';
                if (check == null) {
                  Navigator.pop(context, 'Already added!');
                } else {
                  Navigator.pop(context, 'Vocabulary Added');
                }
              } else if (characterValue != '' && widget.characterName != null) {
                String pinyinValue = PinyinHelper.getPinyin(characterValue,
                    format: PinyinFormat.WITH_TONE_MARK);
                int ifUpdated = await db.updateVocabulary(Vocabulary.fromMap({
                  vColumnVocabularyId: widget.vocabularyId,
                  vColumnVocabularyChapterId: widget.chapterId,
                  vColumnCharacter: characterValue,
                  vColumnPinyin: pinyinValue,
                  vColumnCharacterRead: 0
                }));
                characterValue = '';
                if (ifUpdated == null) {
                  Navigator.pop(context, 'already Exist');
                } else {
                  await getVocabulary(widget.chapterId);
                  Navigator.pop(context, 'succesfully edited');
                }
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

class AddVocabularyCard extends StatelessWidget {
  AddVocabularyCard(
      {@required this.onChanged,
      @required this.onPressed,
      @required this.characterTobeEdited});
  final Function onChanged;
  final Function onPressed;
  final TextEditingController characterTobeEdited;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 50.0),
      color: Color(0xFF0a0d22),
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Add Character',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0),
              child: TextField(
                controller: characterTobeEdited,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Hanzi',
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
