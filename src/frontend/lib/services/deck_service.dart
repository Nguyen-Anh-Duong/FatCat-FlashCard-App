import 'dart:convert';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/services/class_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/deck_model.dart';

class DeckService {
  static final String baseUrl = dotenv.env['BASE_URL']!;

  static Future<bool> shareDeck(DeckModel deck, List<CardModel> cards) async {
    final response =
        await http.post(Uri.parse('$baseUrl/deck/share')); //chua xong
    return true;
  }

  static Future<bool> deleteInServer(String deckId) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/deck/$deckId'));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateDeckToServer(
      String classId, DeckModel deck, List<CardModel> cards) async {
    final headers = await ClassService.getHeaders();
    try {
      // print('===<> ${deck.user_id}');
      String deckId = deck.id!;
      final body = {
        "deck_id": deckId,
        "deck": {
          "user_id": deck.user_id,
          "id": deckId,
          "name": deck.name,
          "description": deck.description,
          "question_language": deck.question_language ?? 'en',
          "answer_language": deck.answer_language ?? 'en',
          "Cards": cards
              .map((item) => {
                    "question": item.question,
                    "answer": item.answer,
                    "id": item.id ?? ''
                  })
              .toList()
        }
      };
      print(body);
      print('deckId:: ${deckId}');
      final response = await http.put(Uri.parse('$baseUrl/deck/${deckId}'),
          headers: headers, body: jsonEncode(body));
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> createDeckToServer(
      String classId, DeckModel deck, List<CardModel> cards) async {
    final headers = await ClassService.getHeaders();
    try {
      final body = {
        "deck": {
          "name": deck.name,
          "description": deck.description,
          "question_language": deck.question_language ?? 'en',
          "answer_language": deck.answer_language ?? 'en',
          "Cards": cards
              .map((item) => {"question": item.question, "answer": item.answer})
              .toList()
        }
      };
      print(body);
      final response = await http.post(
          Uri.parse('$baseUrl/class/$classId/decks'),
          headers: headers,
          body: jsonEncode(body));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
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

  static Future<List<DeckModel>> fetchDecksForClass(String classId) async {
    try {
      final header = await ClassService.getHeaders();
      final response = await http
          .get(Uri.parse('$baseUrl/class/$classId/decks'), headers: header);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('duy');
        final List<dynamic> decks = data['metadata'];
        return decks.map((item) => DeckModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load decks');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
