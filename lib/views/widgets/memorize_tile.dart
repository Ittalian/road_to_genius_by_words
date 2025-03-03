import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_button.dart';

class MemorizeTile extends StatelessWidget {
  final Word word;
  final Function() onPressed;

  const MemorizeTile({
    super.key,
    required this.word,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(word.value),
          Text(word.meaning),
          BaseButton(
            label: '回答',
            onPressed: () => onPressed(),
          ),
        ],
      ),
    );
  }
}
