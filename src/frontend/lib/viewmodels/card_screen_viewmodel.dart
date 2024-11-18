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
}
