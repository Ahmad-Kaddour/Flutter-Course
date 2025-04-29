import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({required this.choosenAnswers, super.key});

  final List<String> choosenAnswers;

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
    final SummaryData = getSummaryData();
    final totalQuestions = questions.length;
    final correctQuestions =
        SummaryData.where(
          (data) => data['correct_answer'] == data['user_answer'],
        ).length;

    return Container(
      margin: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'you answerd $correctQuestions out of $totalQuestions correctly!',
          ),
          SizedBox(height: 30),
          QuestionsSummary(summaryData: SummaryData),
          SizedBox(height: 30),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.replay),
            label: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
