import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/config/routes.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/views/widgets/memorize_tile.dart';

class Memorize extends StatefulWidget {
  final List<Word> words;

  const Memorize({
    super.key,
    required this.words,
  });

  @override
  State<Memorize> createState() => MemorizeState();
}

class MemorizeState extends State<Memorize> {
  int questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MemorizeTile(
        word: widget.words[questionIndex],
        onPressed: () => nextQuiestion(),
      ),
    );
  }

  void nextQuiestion() {
    if (questionIndex < widget.words.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      finishMemorize();
    }
  }

  void finishMemorize() {
    moveSearch();
  }

  void moveSearch() {
    Navigator.pushNamed(
      context,
      Routes.searchWord,
    );
  }
}
