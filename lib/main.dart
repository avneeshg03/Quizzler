import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

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
  List<Widget> scoreKeeper = [];
  void checkAnswer(bool userpickedans) {
    if (quizBrain.isFinished()) {
      Alert(
              context: context,
              title: "Finished!",
              desc: "You have reched the end of quiz!.")
          .show();
      quizBrain.reset();
      scoreKeeper = [];
    } else {
      bool correctAns = quizBrain.getQuestionAnswer();

      setState(() {
        if (userpickedans == correctAns) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQues();
      });
    }
  }

  // List<String> questions = [
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.'
  // ];
  // List<bool> answers = [false, true, true];
  // Question q1 =
  //     Question('You can lead a cow down stairs but not up stairs.', false);
  //THIS IS WHAT IS ABSTRACTION IN OOPS WHERE WE DIVIDE THE CODE INTO MORE AND MORE MODULES:
  //CODE BASE IS MADE MORE REUSABLE AND MORE EFFICIENT
  // List<Question> questionBank = [
  //   Question('Some cats are actually allergic to humans', true),
  //   Question('You can lead a cow down stairs but not up stairs.', false),
  //   Question('Approximately one quarter of human bones are in the feet.', true),
  // ];
  QuizBrain quizBrain = QuizBrain();

  //int i = 0;

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
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                //quizBrain.questionBank[i].questionAnswer=true;
                //this above statement is not safe as user can change the answers
                //Second pillar of OOPS i.e Encapsulation will remove that away
                //We will make our property to be private by adding _ to the property
                //but making questionBank private main dart will also not be able to access the property
                //How we solve that then?
                //Done By Using GETTERS:
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
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

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
