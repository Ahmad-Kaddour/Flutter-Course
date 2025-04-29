import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({required this.onAnswerSelected, super.key});

  final void Function(String) onAnswerSelected;

  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestion = 0;

  void questionAnswered(String answer) {
    widget.onAnswerSelected(answer);
    setState(() {
      currentQuestion++;
    });
  }

  @override
  Widget build(Object context) {
    return Container(
      margin: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            questions[currentQuestion].text,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 182, 153, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30),
          ...questions[currentQuestion].getShuffledAnswers().map(
            (answer) => AnswerButton(
              text: answer,
              onPressed: () => questionAnswered(answer),
            ),
          ),
        ],
      ),
    );
  }
}
