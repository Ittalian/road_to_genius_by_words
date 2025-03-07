import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/config/routes.dart';
import 'package:road_to_genius_by_words/models/memorize_word.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/utils/question_type.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_image_container.dart';
import 'package:road_to_genius_by_words/views/widgets/memorize_selection.dart';
import 'package:road_to_genius_by_words/views/widgets/memorize_tile.dart';

class Memorize extends StatefulWidget {
  final List<Word> words;
  final int questionCount;
  final QuestionType type;

  const Memorize({
    super.key,
    required this.words,
    required this.questionCount,
    required this.type,
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
    getQuestionWords();
  }

  List<String> getSuggestions() {
    List<String> targetSuggestions = questionWords
        .expand((word) => word.answers ?? <String>[])
        .cast<String>()
        .toList();

    targetSuggestions = targetSuggestions.toSet().toList();
    String correctAnswer = questionWords[questionIndex].answers![0];
    targetSuggestions.removeWhere(
        (answer) => questionWords[questionIndex].answers!.contains(answer));
    targetSuggestions.shuffle();
    List<String> selectedSuggestions = targetSuggestions.take(3).toList();
    selectedSuggestions.add(correctAnswer);
    selectedSuggestions.shuffle();

    return selectedSuggestions;
  }

  void getQuestionWords() {
    questionWords = List<Word>.from(widget.words);
    questionWords.shuffle();
    if (widget.questionCount < questionWords.length) {
      questionWords = questionWords.take(widget.questionCount).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseImageContainer(
      imagePath: switch (widget.type) {
        QuestionType.description => 'images/memorize.jpg',
        QuestionType.selection => 'images/memorize_selection.jpg',
      },
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        body: PopScope(
          canPop: false,
          child: switch (widget.type) {
            QuestionType.description => MemorizeTile(
                word: questionWords[questionIndex],
                onPressedAnswer: (answer) => countCorrect(answer),
                finishMemorize: () => moveResultMemorize(),
                answeredAll: answeredAll,
              ),
            QuestionType.selection => MemorizeSelection(
                word: questionWords[questionIndex],
                suggestions: getSuggestions(),
                onPressedAnswer: (answer) => countCorrect(answer),
                finishMemorize: () => moveResultMemorize(),
                answeredAll: answeredAll,
              ),
          },
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

  void setCorrect(Word targetWord, String answer) {
    setState(() {
      correctCount++;
      memorizeWords.add(MemorizeWord(
        word: targetWord,
        answer: answer,
      ));
    });
    showCorrectMessage(context);
    nextQuestion();
  }

  void setInCorrect(Word targetWord, String answer) {
    setState(() {
      memorizeWords.add(MemorizeWord(
        word: targetWord,
        answer: answer,
        correctAnswer: targetWord.answers,
      ));
    });
    showInCorrectErrorMessage(context);
    nextQuestion();
  }

  void countCorrect(String answer) {
    final targetWord = questionWords[questionIndex];
    if (targetWord.answers!.contains(answer)) {
      setCorrect(targetWord, answer);
    } else {
      setInCorrect(targetWord, answer);
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
