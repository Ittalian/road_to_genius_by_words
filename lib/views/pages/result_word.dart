import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_image_container.dart';
import 'package:road_to_genius_by_words/views/widgets/result_word_tile.dart';

class ResultWord extends StatelessWidget {
  final Word word;

  const ResultWord({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: BaseImageContainer(
        imagePath: 'images/result_word.jpg',
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  ResultWordTile(word: word),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
