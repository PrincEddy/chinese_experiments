import 'package:flutter/material.dart';
import 'add_vocabulary_screen.dart';
import 'package:chinese_experiments/models/chinese_data.dart';
import 'package:chinese_experiments/models/vocabulary.dart';
import 'package:flutter/services.dart';

bool isLongPressed = false;
bool isDeleted = false;
bool cancelAllDetected = false;
int countSelected = 0;
List<dynamic> vocabularyListTobeDeleted = [];

class VocabularyScreen extends StatefulWidget {
  VocabularyScreen({@required this.chapterId});
  final chapterId;
  @override
  _VocabularyScreenState createState() =>
      _VocabularyScreenState(chapterId: chapterId);
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  _showDelete() {
    return BottomSheet(onClosing: () {
      print('onclose');
    }, builder: (BuildContext context) {
      return Card(
        color: Colors.white,
        child: ListTile(
          leading: IconButton(
            onPressed: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Tizvibvise zvachose zvachose?'),
                      actions: <Widget>[
                        SizedBox(
                          width: 20.0,
                        ),
                        IconButton(
                          onPressed: () async {
                            await deleteSelectedVocabulary(
                                vocabularyListTobeDeleted);
                            Navigator.pop(context);
                            setState(() {
                              isDeleted = false;
                              isLongPressed = false;
                              cancelAllDetected = true;
                              countSelected = 0;
                              vocabularyListTobeDeleted = [];
                            });
                            await getVocabulary(chapterId);
                          },
                          icon: Icon(
                            Icons.done,
                            color: Colors.red,
                            size: 30.0,
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(
              Icons.delete_forever,
              size: 30.0,
              color: Colors.red,
            ),
          ),
          title: Text(
            '$countSelected Selected',
            style: TextStyle(color: Colors.red),
          ),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                isDeleted = false;
                isLongPressed = false;
                cancelAllDetected = true;
                countSelected = 0;
                vocabularyListTobeDeleted = [];
              });
            },
            icon: Icon(
              Icons.close,
              color: Colors.blue,
              size: 30.0,
            ),
          ),
        ),
      );
    });
  }

  _VocabularyScreenState({@required this.chapterId});
  final chapterId;
  Widget makeVocabularyCards() {
    List<Widget> vocabularyList = [];
    if (vocabulary != null && vocabulary.length != 0) {
      for (int i = 0; i < vocabulary.length; i++) {
        Vocabulary oneVocabulary = Vocabulary.map(vocabulary[i]);
        vocabularyList.add(
          VocabularyCard(
            refreshVocabularyCard: () {
              setState(() {});
            },
            characterName: oneVocabulary.character,
            pinyinName: oneVocabulary.pinyin,
            index: i + 1,
            chapterId: chapterId,
            vocabularyId: oneVocabulary.vocabularyId,
          ),
        );
        vocabularyList.add(Divider(
          height: 1.5,
        ));
      }
    } else {
      vocabularyList.add(Center(
        child: Text(
          'Press the add button to add New Vocabulary',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
          ),
        ),
      ));
    }

    return ListView.builder(
        itemCount: vocabularyList.length,
        addAutomaticKeepAlives: true,
        itemBuilder: (BuildContext vocabularyItems, int index) {
          return vocabularyList[index];
        });
  }

  @override
  Widget build(BuildContext context) {
    getVocabulary(chapterId);
    return Scaffold(
      body: makeVocabularyCards(),
      floatingActionButton: !isDeleted
          ? Builder(
              builder: (context) => FloatingActionButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddVocabularyScreen(
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
            )
          : SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomSheet: isDeleted ? _showDelete() : SizedBox(),
    );
  }
}

class VocabularyCard extends StatefulWidget {
  VocabularyCard(
      {@required this.characterName,
      @required this.pinyinName,
      @required this.index,
      @required this.chapterId,
      @required this.vocabularyId,
      @required this.refreshVocabularyCard});

  final String characterName;
  final String pinyinName;
  final int index;
  final int chapterId;
  final int vocabularyId;
  final Function refreshVocabularyCard;

  @override
  _VocabularyCardState createState() => _VocabularyCardState();
}

class _VocabularyCardState extends State<VocabularyCard> {
  bool isSelected = false;
  Color color = Color(0xED1D8E0);
  bool isSelectedAndDeleted = false;
  @override
  Widget build(BuildContext context) {
    if (cancelAllDetected) {
      color = Color(0xED1D8E0);
      isSelected = false;
      isSelectedAndDeleted = false;
    }
    return Container(
      color: color,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: Text(
            '${widget.index}',
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
          title: Text(
            '${widget.pinyinName}->${widget.characterName}',
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'Meaning: Hello',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.green,
            ),
          ),
          trailing: isDeleted
              ? Checkbox(
                  value: isSelectedAndDeleted,
                  onChanged: (bool value) {
                    setState(() {
                      widget.refreshVocabularyCard();
                      isSelectedAndDeleted = value;
                      if (isSelectedAndDeleted) {
                        color = Color(0xFFD1D8E0);
                        countSelected++;
                      } else {
                        color = Color(0xED1D8E0);
                        countSelected--;
                      }
                    });
                  },
                  checkColor: Colors.red,
                  activeColor: Colors.white,
                )
              : Icon(
                  Icons.volume_down,
                  size: 30.0,
                  color: Colors.blue,
                ),
          enabled: true,
          selected: isSelected,
          onLongPress: () {
            setState(() {
              if (!isSelected && !isLongPressed) {
                _showDialog();
              }
            });
          },
          onTap: () {
            widget.refreshVocabularyCard();
            setState(() {
              if (isDeleted && isSelectedAndDeleted) {
                vocabularyListTobeDeleted.remove(widget.vocabularyId);
                countSelected--;
                color = Color(0xED1D8E0);
                isSelected = false;
                isSelectedAndDeleted = false;
              } else if (isDeleted) {
                countSelected++;
                vocabularyListTobeDeleted.add(widget.vocabularyId);
                color = Color(0xFFD1D8E0);
                isSelected = true;
                isSelectedAndDeleted = true;
              }
            });
          },
        ),
      ),
    );
  }

  _showDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Card(
              color: Color(0xFF1c2833),
              margin: EdgeInsets.only(top: 50, bottom: 70, left: 250),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.content_copy),
                    title: Text('Copy'),
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.characterName));
                      Navigator.pop(context);
                      setState(() {
                        color = Color(0xED1D8E0);
                        isLongPressed = false;
                      });
                    },
                  ),
                  Divider(
                    height: 1.5,
                  ),
                  ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                      onTap: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddVocabularyScreen(
                                      chapterId: widget.chapterId,
                                      characterName: widget.characterName,
                                      vocabularyId: widget.vocabularyId,
                                    )));
                        setState(() {
                          color = Color(0xED1D8E0);
                          isLongPressed = false;
                          if (result != null) {
                            getVocabulary(widget.chapterId);
//                            Scaffold.of(context).showSnackBar(SnackBar(
//                              content: Text('$result'),
//                              duration: Duration(milliseconds: 500),
//                            ));
                          }
                        });
                        Navigator.pop(context);
                      }),
                  Divider(
                    height: 1.5,
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                    onTap: () {
                      widget.refreshVocabularyCard();
                      setState(() {
                        countSelected++;
                        vocabularyListTobeDeleted.add(widget.vocabularyId);
                        color = Color(0xFFD1D8E0);
                        isSelected = true;
                        isLongPressed = true;
                        isDeleted = true;
                        isSelectedAndDeleted = true;
                        cancelAllDetected = false;
                      });

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
