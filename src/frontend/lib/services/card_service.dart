import 'dart:convert';

import 'package:FatCat/models/card_model.dart';
import 'package:http/http.dart' as http;

class CardService {
  final String baseUrl = 'http://172.25.80.1:3056/v1/api';
  Future<List<CardModel>> getCardsByDeckId(String deckId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/card?deckId=$deckId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['metadata'];
        print('====${jsonData}');
        List<CardModel> cards =
            jsonData.map((json) => CardModel.fromJson(json)).toList();
        print('2====${cards}');
        return cards;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
