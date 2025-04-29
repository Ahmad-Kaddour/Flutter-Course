import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.choosenAnswers,
    required this.onRestart,
    super.key,
  });

  final List<String> choosenAnswers;
  final void Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < choosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': choosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final totalQuestions = questions.length;
    final correctQuestions =
        summaryData
            .where((data) => data['correct_answer'] == data['user_answer'])
            .length;

    return Container(
      margin: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'you answerd $correctQuestions out of $totalQuestions correctly!',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 230, 200, 253),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          QuestionsSummary(summaryData),
          SizedBox(height: 30),
          TextButton.icon(
            onPressed: onRestart,
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.refresh),
            label: const Text('Restart Quiz!'),
          ),
        ],
      ),
    );
  }
}
