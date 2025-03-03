import 'package:flutter/material.dart';

class AnswerRatio extends StatelessWidget {
  final int ratio;

  const AnswerRatio({
    super.key,
    required this.ratio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.7),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Text(
        '正答率$ratio%',
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
