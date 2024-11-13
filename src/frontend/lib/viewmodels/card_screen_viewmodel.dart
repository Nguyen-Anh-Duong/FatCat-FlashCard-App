import 'package:FatCat/services/card_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/card_model.dart';
import '../models/deck_model.dart';

class CardScreenViewModel extends ChangeNotifier {
  final DeckModel deck;
  List<CardModel> _cards = [];
  bool _isLoading = false;
  String? _error;

  CardScreenViewModel(this.deck) {
    fetchCards();
  }

  List<CardModel> get cards => _cards;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCards() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await CardService.instance.getCardsByDeckId(deck.id);
      _cards = response;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
