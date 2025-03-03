import 'package:road_to_genius_by_words/models/word.dart';

class MemorizeWord {
  final Word word;
  final String answer;
  final bool isCorrect;

  const MemorizeWord({
    required this.word,
    required this.answer,
    required this.isCorrect,
  });
}
