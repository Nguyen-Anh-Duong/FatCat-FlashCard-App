// ignore_for_file: avoid_print

import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/services/deck_service.dart';
import 'package:FatCat/views/screens/category_screen.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final DeckService deckService = DeckService();
  List<DeckModel> _decks = [];

  List<DeckModel> get decks => _decks;

  Future<void> openCategoryScreen(BuildContext context, String category) async {
    try {
      List<DeckModel> decks = await deckService.getDecks(category);
      notifyListeners();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CategoryScreen(category: category, decks: decks)));
    } catch (e) {
      print(e);
    }
  }
}
