import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'ting_xie_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        children: <Widget>[
          QuizRowCard(
            itemName: 'Tingxie',
            itemName1: 'Recite',
          ),
          QuizRowCard(
            itemName: 'Pinyin',
            itemName1: 'English',
          ),
        ],
      ),
    );
  }
}

class QuizRowCard extends StatelessWidget {
  QuizRowCard({@required this.itemName, @required this.itemName1});
  final String itemName;
  final String itemName1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          QuizItemCard(
            itemName: itemName,
          ),
          QuizItemCard(
            itemName: itemName1,
          ),
        ],
      ),
    );
  }
}

class QuizItemCard extends StatelessWidget {
  QuizItemCard({@required this.itemName});
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (itemName == 'Tingxie') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (TingXieScreen())),
            );
          }
        },
        child: Card(
          margin: EdgeInsets.all(5.0),
          color: Color(0xFF130f40),
          child: Column(
            children: <Widget>[
              Text(
                itemName,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.white,
                  // backgroundImage: AssetImage('images/book1.jpg'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: LinearPercentIndicator(
                  lineHeight: 15.0,
                  backgroundColor: Colors.white,
                  percent: 0.7,
                  progressColor: Colors.blueAccent,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
