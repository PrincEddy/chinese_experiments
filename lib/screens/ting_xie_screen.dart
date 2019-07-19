import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:chinese_experiments/models/chinese_data.dart';
import 'package:chinese_experiments/models/vocabulary.dart';

class TingXieScreen extends StatefulWidget {
  @override
  _TingXieScreenState createState() => _TingXieScreenState();
}

bool groupValue = false;
int i = 0;
int total = allVocabulary.length;

class _TingXieScreenState extends State<TingXieScreen> {
  bool radioValue = false;

  @override
  Widget build(BuildContext context) {
    Vocabulary vocabulary = Vocabulary.map(allVocabulary[i]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tingxie'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Write down the character of the displayed pinyin',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Center(
            child: CircleAvatar(
              radius: 30.0,
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              child: Text(
                '$total',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Center(
            child: Card(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              color: Color(0xFF007FFF),
              child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: Text(
                  '${vocabulary.pinyin}',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (i < allVocabulary.length - 1) {
                        i++;
                        total--;
                      } else {
                        total = 0;
                        i = 0;
                      }
                    });
                  },
                  child: Card(
                    margin: EdgeInsets.only(bottom: 20.0),
                    color: Color(0xFF30FE87),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (i < allVocabulary.length - 1) {
                        i++;
                        total--;
                      } else {
                        total = 0;
                        i = 0;
                      }
                    });
                  },
                  child: Card(
                    margin: EdgeInsets.only(bottom: 20.0),
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                        'No',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: LinearPercentIndicator(
              lineHeight: 15.0,
              backgroundColor: Colors.white,
              percent: 0.7,
              progressColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
