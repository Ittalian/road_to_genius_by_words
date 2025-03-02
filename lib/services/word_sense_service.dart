import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/utils/constants.dart' as constants;

class WordSenseService {
  final String value;

  const WordSenseService({
    required this.value,
  });

  Future<Word?> getWords() async {
    final url = _getUrl(value);
    final target = Uri.parse(url);

    while (true) {
      final response = await http.get(target);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> pages = data['query']['pages'];
        if (pages.isNotEmpty) {
          final page = pages.values.first;
          final String? meaning = page['extract'];
          return Word(value: value, meaning: meaning ?? '定義なし');
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  String _getUrl(String value) {
    return constants.wordSearchUrl + value;
  }

  String extractJsonFromCallback(String responseBody) {
    final regex = RegExp(r'callback\((.*)\)');
    final match = regex.firstMatch(responseBody);
    return match != null ? match.group(1)! : responseBody;
  }
}
