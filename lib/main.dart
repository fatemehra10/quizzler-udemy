import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  checkAnswer(bool answer) {
    setState(() {
      if (quizBrain.getCorrectAnswer() == answer)
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      else
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
    });
    if (quizBrain.getNextQuestion() == (quizBrain.getQuestionbankLength() - 1)) {
      Alert(
          context: context,
          title: "Finished!",
          padding: EdgeInsets.symmetric(horizontal: 10),
          desc: "You've reached end of quiz.",
          buttons: [
            DialogButton(
              padding: EdgeInsets.all(10),
              color: Colors.lightBlueAccent,
                width: 210,
                height: 50,
                child: new Text("CANCEL" , style: TextStyle(color: Colors.white),),
                onPressed: () {
                  setState(() {
                    scoreKeeper.removeRange(
                        0, quizBrain.getQuestionbankLength()-1);
                  });
                  Navigator.pop(context);
                }),
          ],).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getCorrectText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () => checkAnswer(true),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () => checkAnswer(false),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
