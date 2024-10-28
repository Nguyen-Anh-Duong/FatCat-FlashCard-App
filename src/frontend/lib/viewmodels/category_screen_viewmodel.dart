import 'package:FatCat/models/deck_model.dart';
import 'package:flutter/foundation.dart';

class CategoryScreenViewModel extends ChangeNotifier {
  List<DeckModel> _decks;

  CategoryScreenViewModel({required List<DeckModel> decks}) : _decks = decks;

  List<DeckModel> get decks => _decks;

  void filterDecks(String query) {
    if (query.isEmpty) {
      _decks = _decks;
    } else {
      _decks = _decks
          .where(
              (deck) => deck.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void sortDecks({required bool ascending}) {
    _decks.sort((a, b) =>
        ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    notifyListeners();
  }

  int get deckCount => _decks.length;
}
