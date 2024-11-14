import 'package:flutter/material.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/services/DatabaseHelper.dart';

class DecksControlViewModel extends ChangeNotifier {
  //singleton
  static final DecksControlViewModel instance =
      DecksControlViewModel._internal();
  factory DecksControlViewModel() => instance;
  DecksControlViewModel._internal();

  List<DeckModel> _decks = [];
  bool _isLoading = false;
  String? _error;

  List<DeckModel> get decks => _decks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchDecks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _decks = await getAllDeck('name');
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
