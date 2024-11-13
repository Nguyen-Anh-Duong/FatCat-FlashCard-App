import 'dart:convert';

import 'package:FatCat/models/card_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CardService {
  //Omg singleton
  static final CardService instance = CardService._internal();
  factory CardService() => instance;
  CardService._internal();
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  Future<List<CardModel>> getCardsByDeckId(String deckId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/card/$deckId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['metadata'];
        List<CardModel> cards =
            jsonData.map((json) => CardModel.fromJson(json)).toList();
        return cards;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
