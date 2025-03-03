import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/config/routes.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/services/word_memorize_service.dart';
import 'package:road_to_genius_by_words/services/word_sense_service.dart';
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

  void moveMemorize(BuildContext context, List<Word> words) {
    Navigator.pushNamed(
      context,
      Routes.memorize,
      arguments: {
        'words': words,
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
          tooltip: '暗記を始める',
          child: const Icon(Icons.memory),
          onPressed: () async {
            await LoadingDialog.show(context, '暗記を始めます');
            List<Word> words = await WordMemorizeService().fetchWords();
            await LoadingDialog.hide(context);
            moveMemorize(context, words);
          },
        ),
      ),
    );
  }
}
