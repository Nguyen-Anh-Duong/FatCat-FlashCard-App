import 'package:flutter/material.dart';

class DeckProvider extends ChangeNotifier {
  List<Map<String, dynamic>> deckData = [];

  void addDeck(Map<String, dynamic> deck) {
    deckData.add(deck);
    notifyListeners();
  }

  void removeDeck(Map<String, dynamic> deck) {
    deckData.remove(deck);
    notifyListeners();
  }
}
