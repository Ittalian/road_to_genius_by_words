import 'package:flutter/material.dart';
import 'package:road_to_genius_by_words/views/pages/memorize.dart';
import 'package:road_to_genius_by_words/views/pages/result_word.dart';
import 'package:road_to_genius_by_words/views/pages/search_word.dart';

class Routes {
  static const String searchWord = 'search_word';
  static const String resultWord = 'result_word';
  static const String memorize = 'memorize';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case searchWord:
        return MaterialPageRoute(
          builder: (_) => const SearchWord(),
        );
      case resultWord:
        final resultWordOptions = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => ResultWord(
            word: resultWordOptions['word'],
          ),
        );
      case memorize:
        final memorizeOptions = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => Memorize(
            words: memorizeOptions['words'],
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name}は存在しません',
                  style: const TextStyle(fontSize: 20)),
            ),
          ),
        );
    }
  }
}
