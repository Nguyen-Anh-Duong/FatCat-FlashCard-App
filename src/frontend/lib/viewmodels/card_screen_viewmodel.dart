import 'package:FatCat/services/DatabaseHelper.dart';
import 'package:FatCat/services/card_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/card_model.dart';
import '../models/deck_model.dart';

class CardScreenViewModel extends ChangeNotifier {
  DeckModel deck;
  final bool? isLocal;
  List<CardModel> _cards = [];
  bool _isLoading = false;
  String? _error;

  CardScreenViewModel(this.deck, {this.isLocal}) {
    loadCards();
  }
  loadCards() async {
    print('====loadCards====');
    if (isLocal != null && isLocal == true) {
      _cards = await getCard(deck.id!);
      notifyListeners();
    } else {
      _cards = await CardService.instance.getCardsByDeckId(deck.id!);
      notifyListeners();
    }
  }

  Future<DeckModel> loadDeck() async {
    if (isLocal != null && isLocal == true) {
      deck = (await getDeckWithId(deck.id!))[0];
      print('===deckFetchAgain===');
      print(deck);
      notifyListeners();
      return deck;
    } else {
      return deck;
    }
  }

  List<CardModel> get cards => _cards;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCards() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await CardService.instance.getCardsByDeckId(deck.id!);
      _cards = response;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteAllCardsForDeck(String deckId) async {
    int rs = await deleteDeck(deckId);
    if (rs == 1) {
      loadCards();
      return true;
    }
    return false;
  }

  Future<bool> cloneDecks() async {
    if (_cards.isEmpty) return false;
    Map<String, String> deckData = {
      "name": deck.name,
      'description': deck.description,
      'deck_cards_count': cards.length.toString(),
      'is_published': 'true',
      'question_language': deck.question_language ?? 'en-US',
      'answer_language': deck.answer_language ?? 'en-US',
      'category_name': deck.category_name ?? 'Khác',
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };

    List<Map<String, String>> cardsData = cards.map((card) {
      return {
        'question': card.question,
        'answer': card.answer,
      };
    }).toList();

    bool rs = await createDeckWithCards(deckData: deckData, cards: cardsData);

    return rs;
  }
}
