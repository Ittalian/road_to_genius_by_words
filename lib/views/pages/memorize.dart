import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/config/routes.dart';
import 'package:road_to_genius_by_words/models/memorize_word.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_image_container.dart';
import 'package:road_to_genius_by_words/views/widgets/memorize_tile.dart';

class Memorize extends StatefulWidget {
  final List<Word> words;
  final int questionCount;

  const Memorize({
    super.key,
    required this.words,
    required this.questionCount,
  });

  @override
  State<Memorize> createState() => MemorizeState();
}

class MemorizeState extends State<Memorize> {
  int questionIndex = 0;
  int correctCount = 0;
  bool answeredAll = false;
  List<Word> questionWords = [];
  List<MemorizeWord> memorizeWords = [];

  @override
  void initState() {
    super.initState();
    questionWords = List<Word>.from(widget.words);
    questionWords.shuffle();
    if (widget.questionCount < questionWords.length) {
      questionWords = questionWords.take(widget.questionCount).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseImageContainer(
      imagePath: 'images/memorize.jpg',
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        body: MemorizeTile(
          word: questionWords[questionIndex],
          onPressedAnswer: (answer) => countCorrect(answer),
          finishMemorize: () => moveResultMemorize(),
          answeredAll: answeredAll,
        ),
      ),
    );
  }

  void nextQuestion() {
    if (questionIndex < questionWords.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      setState(() {
        answeredAll = true;
      });
    }
  }

  void countCorrect(String answer) {
    final targetWord = questionWords[questionIndex];
    if (targetWord.meaning == answer) {
      setState(() {
        correctCount++;
        memorizeWords.add(MemorizeWord(
          word: targetWord,
          answer: answer,
          isCorrect: true,
        ));
      });
      showCorrectMessage(context);
      nextQuestion();
    } else {
      setState(() {
        memorizeWords.add(MemorizeWord(
          word: targetWord,
          answer: answer,
          isCorrect: false,
        ));
      });
      showInCorrectErrorMessage(context);
      nextQuestion();
    }
  }

  void moveResultMemorize() {
    Navigator.pushNamed(
      context,
      Routes.resultMemorize,
      arguments: {
        'memorizeWords': memorizeWords,
        'correctCount': correctCount,
      },
    );
  }

  showCorrectMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('正解！'),
        backgroundColor: Colors.blue,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.black,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  showInCorrectErrorMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('不正解'),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }
}
