import 'package:FatCat/constants/card_data_test.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier {
  List<CardModel> cardData = cardsForDeck1;

  void addDeck(CardModel card) {
    cardData.add(card);
    //todo

    notifyListeners();
  }

  void removeDeck(CardModel card) {
    cardData.remove(card);
    notifyListeners();
  }
}
