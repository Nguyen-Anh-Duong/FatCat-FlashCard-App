import 'package:FatCat/services/DatabaseHelper.dart';
import 'package:FatCat/services/card_service.dart';
import 'package:FatCat/services/deck_service.dart';
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
  int _currentIndex = 0;

  CardScreenViewModel(this.deck, {this.isLocal}) {
    loadCards();
  }

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    if (index > 4) index = 2;
    _currentIndex = index;

    notifyListeners();
  }

  Future<bool> shareDeck() async {
    return await DeckService.shareDeck(deck, _cards);
  }

  Future<void> loadCards() async {
    print('====loadCards====');
    _isLoading = true;
    notifyListeners();
    try {
      if (isLocal != null && isLocal == true) {
        print('===isLocal===');
        await Future.delayed(const Duration(milliseconds: 450));
        _cards = await getCard(deck.id!);
      } else {
        print('===isRemote===');
        await Future.delayed(const Duration(milliseconds: 450));
        _cards = await CardService.instance.getCardsByDeckId(deck.id!);
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false; // Kết thúc loading
      notifyListeners(); // Cập nhật UI
    }
  }

  Future<DeckModel> loadDeck() async {
    if (isLocal != null && isLocal == true) {
      deck = (await getDeckWithId(deck.id!))[0];
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

  Future<void> deleteInServer(String id) async {
    await DeckService.deleteInServer(id);
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
