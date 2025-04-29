import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartQuizScreen extends StatelessWidget {
  final void Function() onStartQuizClicked;

  const StartQuizScreen({required this.onStartQuizClicked, super.key});

  @override
  Widget build(Object context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/quiz-logo.png',
          height: 300,
          color: const Color.fromARGB(150, 255, 255, 255),
        ),
        SizedBox(height: 40),
        Text(
          "Learn Flutter the fun way!",
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(color: Colors.white, fontSize: 24),
        ),
        SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: onStartQuizClicked,
          style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
          icon: Icon(Icons.arrow_right_alt),
          label: Text("Start Quiz"),
        ),
      ],
    );
  }
}
