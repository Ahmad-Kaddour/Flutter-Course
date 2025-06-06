class QuizQuestion {
  final String text;
  final List<String> answers;

  const QuizQuestion(this.text, this.answers);

  List<String> getShuffledAnswers() {
    final shaffled = List.of(answers);
    shaffled.shuffle();
    return shaffled;
  }
}
