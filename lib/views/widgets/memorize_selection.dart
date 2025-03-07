import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_button.dart';

class MemorizeSelection extends StatefulWidget {
  final Word word;
  final List<String> suggestions;
  final Function(String) onPressedAnswer;
  final Function() finishMemorize;
  final bool answeredAll;

  const MemorizeSelection({
    super.key,
    required this.word,
    required this.suggestions,
    required this.onPressedAnswer,
    required this.finishMemorize,
    required this.answeredAll,
  });

  @override
  State<MemorizeSelection> createState() => MemorizeSelectionState();
}

class MemorizeSelectionState extends State<MemorizeSelection> {
  String answer = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      answer = widget.suggestions[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            Container(
              color: Colors.white.withOpacity(0.5),
              padding: const EdgeInsets.fromLTRB(0, 10, 6, 10),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!widget.answeredAll)
                    Text(
                      widget.word.value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  if (!widget.answeredAll)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var suggestion in widget.suggestions) ...{
                          Radio<String>(
                            value: suggestion,
                            groupValue: answer,
                            onChanged: (String? value) {
                              setState(() {
                                if (value != null) {
                                  answer = value;
                                }
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              suggestion,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        },
                      ],
                    ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  BaseButton(
                    label: widget.answeredAll ? '解答を見る' : '回答',
                    onPressed: widget.answeredAll
                        ? () => widget.finishMemorize()
                        : () {
                            widget.onPressedAnswer(answer);
                            setState(() {
                              answer = '';
                            });
                          },
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}
