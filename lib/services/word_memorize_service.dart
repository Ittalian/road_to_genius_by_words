import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:road_to_genius_by_words/models/word.dart';

import 'package:http/http.dart' as http;

class WordMemorizeService {
  Future<List<Word>> fetchWords() async {
    final String accessToken = dotenv.get('access_token');

    final url = _getUrl();
    final target = Uri.parse(url);

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Notion-Version': '2021-05-13',
    };
    final body = jsonEncode({});
    final response = await http.post(target, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      if (results.isNotEmpty) {
        return results.map<Word>((result) {
          return Word(
            value: result['properties']['名前']['title'][0]['plain_text'],
            meaning: result['properties']['意味']['rich_text'][0]['plain_text'],
          );
        }).toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  String _getUrl() {
    String databaseId = dotenv.get('database_id');
    return 'https://api.notion.com/v1/databases/$databaseId/query';
  }
}
