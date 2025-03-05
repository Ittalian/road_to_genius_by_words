import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/models/memorize_word.dart';

class MemorizeWordTile extends StatelessWidget {
  final MemorizeWord memorizeWord;
  final int quistionIndex;

  const MemorizeWordTile({
    super.key,
    required this.memorizeWord,
    required this.quistionIndex,
  });

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 20,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$quistionIndex問目',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        Text(
          '問題：${memorizeWord.word.value}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        Text(
          memorizeWord.correctAnswer == null ? '正解' : '不正解',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: memorizeWord.correctAnswer == null ? Colors.blue : Colors.red,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          'あなたの回答：${memorizeWord.answer == '' ? '未回答' : memorizeWord.answer}',
          style: style,
        ),
        if (memorizeWord.correctAnswer != null)
          Text(
            '正しい回答：${memorizeWord.correctAnswer!.join(', ')}',
            style: style,
          ),
        const Padding(padding: EdgeInsets.only(top: 30)),
      ],
    );
  }
}
