import 'package:FatCat/constants/deck_data_test.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:flutter/material.dart';

class DeckProvider extends ChangeNotifier {
  List<DeckModel> deckData = decks;

  void addDeck(DeckModel deck) {
    deckData.add(deck);
    //todo

    notifyListeners();
  }

  void removeDeck(DeckModel deck) {
    deckData.remove(deck);
    notifyListeners();
  }
}
