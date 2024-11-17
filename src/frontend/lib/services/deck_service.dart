import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/deck_model.dart';

class DeckService {
  static final String baseUrl = dotenv.env['BASE_URL']!;

  Future<List<DeckModel>> getDecks(String categoryName) async {
    try {
      print('$baseUrl/deck/category?categoryName=$categoryName');

      final response = await http.get(
        Uri.parse('$baseUrl/deck/category?categoryName=$categoryName'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['metadata'];
        print(jsonData[0]);
        await Future.delayed(const Duration(milliseconds: 100));
        return jsonData.map((json) => DeckModel.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load decks. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching decks: $e');
    }
  }

  static Future<List<DeckModel>> fetchDecks() async {
    final response = await http.get(Uri.parse('$baseUrl/deck'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> decks = data['metadata'];
      print('111');
      return decks.map((item) => DeckModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load decks');
    }
  }
}
