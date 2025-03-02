import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/config/routes.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/services/word_save_service.dart';
import 'package:road_to_genius_by_words/views/widgets/base/base_text_button.dart';
import 'package:road_to_genius_by_words/views/widgets/loading/loading_dialog.dart';

class ResultWordTile extends StatelessWidget {
  final Word word;

  const ResultWordTile({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(word.value),
          Text(word.meaning),
          const Padding(padding: EdgeInsets.only(top: 10)),
          BaseTextButton(
            onPressed: () async {
              try {
                await LoadingDialog.show(context, ('保存中'));
                await WordSaveService(word: word).save();
                await LoadingDialog.hide(context);
                showMessage(context, '保存しました');
                moveSearch(context);
              } catch (e) {
                await LoadingDialog.hide(context);
                showErrorMessage(context, 'ネットワークエラー: $e');
              }
            },
            label: 'Notionに保存',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void moveSearch(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.searchWord,
    );
  }

  showMessage(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.black,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  showErrorMessage(BuildContext context, String errorMessage) {
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
}
