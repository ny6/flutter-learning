import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

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
  Icon rightAnswer = Icon(Icons.check, color: Colors.green);
  Icon wrongAnswer = Icon(Icons.close, color: Colors.red);

  List<Icon> scoreKeeper = [];

  Expanded createButton({Color color, String text, bool value}) {
    void checkAnswer() {
      Icon answer = wrongAnswer;

      if (quizBrain.getAnswer() == value) {
        answer = rightAnswer;
      }

      setState(() {
        scoreKeeper.add(answer);
      });

      if (quizBrain.isItLastQuestion()) {
        Alert(
            context: context,
            title: "Game Over",
            desc: "Press End Game or close alert to start new game!",
            closeFunction: () {
              setState(() {
                scoreKeeper = [];
              });
              quizBrain.resetQuiz();
            },
            buttons: [
              DialogButton(
                child: Text('End Game', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    scoreKeeper = [];
                    Navigator.pop(context);
                  });
                  quizBrain.resetQuiz();
                },
              )
            ]).show();
      } else {
        quizBrain.nextQuestion();
      }
    }

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          textColor: Colors.white,
          color: color,
          child: Text(text, style: TextStyle(fontSize: 20.0)),
          onPressed: checkAnswer,
        ),
      ),
    );
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
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        createButton(color: Colors.green, text: 'True', value: true),
        createButton(color: Colors.red, text: 'False', value: false),
        Row(children: scoreKeeper),
      ],
    );
  }
}
