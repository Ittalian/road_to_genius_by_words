import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_button.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_textform_field.dart';

class MemorizeTile extends StatefulWidget {
  final Word word;
  final Function(String) onPressedAnswer;
  final Function() finishMemorize;
  final bool answeredAll;

  const MemorizeTile({
    super.key,
    required this.word,
    required this.onPressedAnswer,
    required this.finishMemorize,
    required this.answeredAll,
  });

  @override
  State<MemorizeTile> createState() => MemorizeTileState();
}

class MemorizeTileState extends State<MemorizeTile> {
  String answer = '';
  final TextEditingController controller = TextEditingController();

  void setAnswer(String value) {
    setState(() {
      answer = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!widget.answeredAll)
          Text(widget.word.value),
          if (!widget.answeredAll)
          BaseTextformField(
            controller: controller,
            label: '意味',
            setValue: (value) => setAnswer(value),
          ),
          BaseButton(
            label: widget.answeredAll ? '解答を見る' : '回答',
            onPressed: widget.answeredAll
                ? () => widget.finishMemorize()
                : () {
                    widget.onPressedAnswer(answer);
                    setState(() {
                      answer = '';
                    });
                    controller.clear();
                  },
          ),
        ],
      ),
    );
  }
}
