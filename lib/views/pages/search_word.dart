import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/config/routes.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/services/word_memorize_service.dart';
import 'package:road_to_genius_by_words/services/word_sense_service.dart';
import 'package:road_to_genius_by_words/utils/question_type.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_button.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_image_container.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_textform_field.dart';
import 'package:road_to_genius_by_words/views/widgets/loading/loading_dialog.dart';

class SearchWord extends StatefulWidget {
  const SearchWord({
    super.key,
  });

  @override
  State<SearchWord> createState() => SearchWordState();
}

class SearchWordState extends State<SearchWord> {
  String wordValue = '';

  void setwordValue(String value) {
    setState(() {
      wordValue = value;
    });
  }

  void moveResult(BuildContext context, Word word) {
    Navigator.pushNamed(
      context,
      Routes.resultWord,
      arguments: {
        'word': word,
      },
    );
  }

  showErrorMessage(String errorMessage) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  void moevMemorizeStart() {
    Navigator.pushNamed(
      context,
      Routes.memorizeStart,
    );
  }

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

  Future<void> showQuestionCountDialog() async {
    TextEditingController countController = TextEditingController();

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        QuestionType? selectedType = QuestionType.description;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '問題数',
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    controller: countController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '問題形式',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<QuestionType>(
                        value: QuestionType.description,
                        groupValue: selectedType,
                        onChanged: (QuestionType? value) {
                          setState(() {
                            if (value != null) {
                              selectedType = value;
                            }
                          });
                        },
                      ),
                      const Text("記述"),
                      Radio<QuestionType>(
                        value: QuestionType.selection,
                        groupValue: selectedType,
                        onChanged: (QuestionType? value) {
                          setState(() {
                            if (value != null) {
                              selectedType = value;
                            }
                          });
                        },
                      ),
                      const Text("選択"),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    await LoadingDialog.show(context, '暗記を始めます');
                    List<Word> words = await WordMemorizeService().fetchWords();
                    int questionCount = countController.text.isEmpty
                        ? words.length
                        : int.tryParse(countController.text) ?? words.length;
                    await LoadingDialog.hide(context);
                    moveMemorize(context, words, questionCount, selectedType!);
                  },
                  child: const Text("開始"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("キャンセル"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseImageContainer(
      imagePath: 'images/search_word.jpg',
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseTextformField(
              label: '語彙',
              setValue: (value) => setwordValue(value),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            BaseButton(
              label: '検索',
              onPressed: () async {
                await LoadingDialog.show(context, ('検索中'));
                Word? word =
                    await WordSenseService(value: wordValue).getWords();
                await LoadingDialog.hide(context);
                if (word == null) {
                  throw showErrorMessage('該当する語彙がありません');
                } else {
                  moveResult(context, word);
                }
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'テストを開始する',
          child: const Icon(Icons.edit_document),
          onPressed: () => moevMemorizeStart(),
        ),
      ),
    );
  }
}
