import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import '../services/database.dart';
import '../utils/globals.dart';
import '../utils/constants.dart';
import '../widgets/keyboard_widget.dart';
import '../widgets/score_in_practice_widget.dart';
import '../widgets/display_task.dart';
import '../widgets/widget_functions.dart';
import '../widgets/message_widget.dart';
import '../screens/tab_navigation_screen.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  AudioPlayer player = AudioPlayer();
  int _firstFactor = -1;
  int _secondFactor = -1;
  int _numWrongAnswers = -1;
  int _numCorrectAnswers = -1;
  String _currentAnswerStr = "";
  bool _blockNewClicks = false;
  TaskBoxStatus _leftSideStatus = TaskBoxStatus.displayTask;
  TaskBoxStatus _rightSideStatus = TaskBoxStatus.displayTask;
  final TextEditingController _controllerText = TextEditingController();
  final ConfettiController _controllerConf = ConfettiController();
  bool isPlayngConfetti = false;

  @override
  void initState() {
    super.initState();
    List<int> task = Globals.loggedPerson.getMultiplicationTask();
    _firstFactor = task[0];
    _secondFactor = task[1];
    _numCorrectAnswers = 0;
    _numWrongAnswers = 0;
    _controllerConf.stop();
  }

  @override
  void dispose() async {
    super.dispose();
    await DatabaseService().updatePersonToDatabase(Globals.loggedPerson);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: <Widget>[
            addVerticalSpace(30),
            Text(Globals.loggedPerson.practiceNumbersSentence(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            addVerticalSpace(5),
            ScoreInPracticeWidget(_numCorrectAnswers, _numWrongAnswers),
            addVerticalSpace(10),
            DisplayTask(
              _firstFactor,
              _secondFactor,
              _currentAnswerStr,
              _leftSideStatus,
              _rightSideStatus,
            ),
            addVerticalSpace(30),
            Keyboard(_numberButtonClicked),
            addVerticalSpace(50),
            GestureDetector(
              onTap: () {
                Globals.showPracticeScreen = false;
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => TabNavigationScreen()));
              },
              child: Container(
                width: 0,
                height: 0,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/back.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        ConfettiWidget(
          confettiController: _controllerConf,
          shouldLoop: false,
          blastDirectionality: BlastDirectionality.explosive,
          emissionFrequency: 0.2,
          numberOfParticles: 40,
          minBlastForce: 5,
          maxBlastForce: 50,
          gravity: 0.5,
        )
      ],
    );
  }

  Future<void> _displayTaskWhenDoneCorrect() async {
    Globals.waitForAnimation = true;
    if (Globals.loggedPerson.sound) {
      player.play(AssetSource("correct.mp3"));
    }
    setState(
      () {
        _blockNewClicks = true;
      },
    );
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      _leftSideStatus = TaskBoxStatus.correctAnswer;
      _rightSideStatus = TaskBoxStatus.correctAnswer;
    });

    await Future.delayed(const Duration(milliseconds: 700));
    _setNewTask();
    Globals.waitForAnimation = false;
  }

  Future<void> _displayTaskWhenDoneWrong(int correctAnswer) async {
    Globals.waitForAnimation = true;
    if (Globals.loggedPerson.sound) {
      player.play(AssetSource("wrong.mp3"));
    }
    setState(() {
      _leftSideStatus = TaskBoxStatus.wrongAnswer;
      _rightSideStatus = TaskBoxStatus.wrongAnswer;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    _showCorrectAnswer(correctAnswer);
    Globals.waitForAnimation = false;
  }

  void _showCorrectAnswer(int correctAnswer) async {
    Globals.waitForAnimation = true;
    if (!Globals.loggedPerson.showCorrectAnswer) {
      _setNewTask();
      return;
    }
    setState(() {
      _currentAnswerStr = "";
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _leftSideStatus = TaskBoxStatus.wrongAnswer;
      _rightSideStatus = TaskBoxStatus.fixedAnswer;
      _currentAnswerStr = correctAnswer.toString();
    });
    await Future.delayed(const Duration(milliseconds: 3000));
    _setNewTask();
    Globals.waitForAnimation = false;
  }

  void _setNewTask() {
    setState(() {
      List<int> newTask = Globals.loggedPerson.getMultiplicationTask();
      _firstFactor = newTask[0];
      _secondFactor = newTask[1];
      _currentAnswerStr = "";
      _leftSideStatus = TaskBoxStatus.displayTask;
      _rightSideStatus = TaskBoxStatus.displayTask;
      _blockNewClicks = false;
    });
  }

  void _playConffeti(int miliseconds) async {
    _controllerConf.play();
    await Future.delayed(Duration(milliseconds: miliseconds));
    _controllerConf.stop();
  }

  Future<void> _numberButtonClicked(String clickedButton) async {
    setState(
      () {
        if (_blockNewClicks) return;
        if (clickedButton == "D") {
          _currentAnswerStr = _currentAnswerStr.isNotEmpty
              ? _currentAnswerStr.substring(0, _currentAnswerStr.length - 1)
              : "";
        } else {
          _currentAnswerStr = _currentAnswerStr + clickedButton;
        }
        _controllerText.text = _currentAnswerStr;
        int correctAnswerInt = _firstFactor * _secondFactor;
        int numDigits = 3;
        if (correctAnswerInt < 100) {
          numDigits = 2;
        }
        if (correctAnswerInt < 10) {
          numDigits = 1;
        }

        if (_currentAnswerStr.isNotEmpty &&
            numDigits <= _currentAnswerStr.length &&
            !_blockNewClicks) {
          _blockNewClicks = true;
          Globals.loggedPerson.incrementAttempts(_firstFactor, _secondFactor);
          if (correctAnswerInt == int.parse(_currentAnswerStr)) {
            _numCorrectAnswers = _numCorrectAnswers + 1;
            Globals.loggedPerson.incrementNumCorrect(_firstFactor, _secondFactor);
            Globals.loggedPerson.incrementStrikes(_firstFactor, _secondFactor);
            _displayTaskWhenDoneCorrect();
            setState(
              () {
                _blockNewClicks = false;
              },
            );
            bool hasMessage = messageWidget(context, _firstFactor, _secondFactor);
            if (hasMessage) {
              _playConffeti(800);
            }
          } else {
            _numWrongAnswers = _numWrongAnswers + 1;
            _displayTaskWhenDoneWrong(correctAnswerInt);
            Globals.loggedPerson.resetStrikes(_firstFactor, _secondFactor);
          }
        }
      },
    );
  }
}
