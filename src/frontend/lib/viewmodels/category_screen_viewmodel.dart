import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/services/card_service.dart';
import 'package:FatCat/views/screens/intermittent_study_screen.dart';
import 'package:FatCat/views/screens/self_study_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryScreenViewModel extends ChangeNotifier {
  List<DeckModel> _decks;

  CategoryScreenViewModel({required List<DeckModel> decks}) : _decks = decks;

  List<DeckModel> get decks => _decks;
  List<CardModel> _cards = [];

  int get deckCount => _decks.length;
  List<CardModel> get cards => _cards;

  Future<void> getCards(String deckId) async {
    final cards = await CardService().getCardsByDeckId(deckId);
    _cards = cards;
    notifyListeners();
  }

  void routeToSelfStudyScreen(BuildContext context, String deckId) {
    getCards(deckId);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelfStudyScreen(cards: _cards)),
    );
  }

  void routeToIntermittentStudyScreen(BuildContext context, String deckId) {
    getCards(deckId);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => IntermittentStudyScreen(cards: _cards)),
    );
  }
}
