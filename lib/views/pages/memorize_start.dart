import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/config/routes.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/services/word_memorize_service.dart';
import 'package:road_to_genius_by_words/utils/question_type.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_button.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_image_container.dart';
import 'package:road_to_genius_by_words/views/widgets/loading/loading_dialog.dart';

class MemorizeStart extends StatefulWidget {
  const MemorizeStart({
    super.key,
  });

  @override
  State<MemorizeStart> createState() => MemorizeStartState();
}

class MemorizeStartState extends State<MemorizeStart> {
  TextEditingController countController = TextEditingController();
  QuestionType questionType = QuestionType.description;

  void moveMemorize(BuildContext context, List<Word> words, int questionCount,
      QuestionType type) {
    Navigator.pushNamed(
      context,
      Routes.memorize,
      arguments: {
        'words': words,
        'questionCount': questionCount,
        'type': type,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseImageContainer(
      imagePath: 'images/memorize_start.jpg',
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '問題数',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(120, 0, 120, 30),
                        child: TextField(
                          controller: countController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text(
                        '問題形式',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio<QuestionType>(
                            value: QuestionType.description,
                            groupValue: questionType,
                            onChanged: (QuestionType? value) {
                              setState(() {
                                if (value != null) {
                                  questionType = value;
                                }
                              });
                            },
                          ),
                          const Text(
                            "記述",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Radio<QuestionType>(
                            value: QuestionType.selection,
                            groupValue: questionType,
                            onChanged: (QuestionType? value) {
                              setState(() {
                                if (value != null) {
                                  questionType = value;
                                }
                              });
                            },
                          ),
                          const Text(
                            "選択",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      BaseButton(
                        label: '開始',
                        onPressed: () async {
                          await LoadingDialog.show(context, '暗記を始めます');
                          List<Word> words =
                              await WordMemorizeService().fetchWords();
                          int questionCount = countController.text.isEmpty
                              ? words.length
                              : int.tryParse(countController.text) ??
                                  words.length;
                          await LoadingDialog.hide(context);
                          moveMemorize(
                            context,
                            words,
                            questionCount,
                            questionType,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
