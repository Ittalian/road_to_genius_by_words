import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:road_to_genius_by_words/models/word.dart';
import 'package:road_to_genius_by_words/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;

class WordSaveService {
  final Word word;

  const WordSaveService({
    required this.word,
  });

  Future<void> save(String meaning) async {
    final String accessToken = dotenv.get('access_token');
    final String databaseId = dotenv.get('database_id');

    final url = Uri.parse(constants.saveUrl);
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Notion-Version': '2021-05-13',
    };

    final body = jsonEncode(
      {
        "parent": {"database_id": databaseId},
        "icon": {"type": "emoji", "emoji": "🔡"},
        "properties": {
          "名前": {
            "title": [
              {
                "text": {"content": word.value}
              }
            ]
          },
          "意味": {
            "rich_text": [
              {
                "text": {"content": meaning}
              }
            ]
          },
          "解答例": {
            "multi_select": word.answers,
          }
        }
      },
    );

    await http.post(url, headers: headers, body: body);
  }
}
