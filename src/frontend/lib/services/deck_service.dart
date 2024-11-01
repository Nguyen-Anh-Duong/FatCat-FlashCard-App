import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/deck_model.dart';

class DeckService {
  String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:3056/v1/api';
    }
    return 'http://172.25.80.1:3056/v1/api';
  }

  Future<List<DeckModel>> getDecks(String categoryName) async {
    try {
      print('$baseUrl/deck/category?categoryName=$categoryName');

      final response = await http.get(
        Uri.parse('$baseUrl/deck/category?categoryName=$categoryName'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['metadata'];
        print(jsonData[0]);
        await Future.delayed(const Duration(milliseconds: 300));
        return jsonData.map((json) => DeckModel.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load decks. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching decks: $e');
    }
  }
}
