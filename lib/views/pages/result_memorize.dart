import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/config/routes.dart';
import 'package:road_to_genius_by_words/models/memorize_word.dart';
import 'package:road_to_genius_by_words/views/widgets/answer_ratio.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_image_container.dart';
import 'package:road_to_genius_by_words/views/widgets/memorize_word_tile.dart';

class ResultMemorize extends StatelessWidget {
  final List<MemorizeWord> memorizeWords;
  final int correctCount;

  const ResultMemorize({
    super.key,
    required this.memorizeWords,
    required this.correctCount,
  });

  @override
  Widget build(BuildContext context) {
    int answerRatio = (correctCount / memorizeWords.length * 100).toInt();
    return PopScope(
      canPop: false,
      child: BaseImageContainer(
        imagePath: answerRatio > 50
            ? 'images/memorize_high.jpg'
            : 'images/memorize_low.jpg',
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.7),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var index = 0; index < memorizeWords.length; index++)
                        MemorizeWordTile(
                          memorizeWord: memorizeWords[index],
                          quistionIndex: index + 1,
                        ),
                    ],
                  ),
                ),
                AnswerRatio(
                  ratio: answerRatio,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'ホームに戻る',
            onPressed: () => moveSearch(context),
            child: const Icon(Icons.home),
          ),
        ),
      ),
    );
  }

  void moveSearch(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.searchWord,
    );
  }
}
