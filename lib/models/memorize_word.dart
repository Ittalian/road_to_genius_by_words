import 'package:road_to_genius_by_words/models/word.dart';

class MemorizeWord {
  final Word word;
  final String answer;
  final List<String>? correctAnswer;

  const MemorizeWord({
    required this.word,
    required this.answer,
    this.correctAnswer,
  });
}
