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
  List<DeckModel> _decksDownloaded = [];

  bool _isLoading = false;
  String? _error;

  List<DeckModel> get decks => _decks;
  List<DeckModel> get decksDownloaded => _decksDownloaded;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Future<void> fetchData() async {
    await fetchDecks();
    await fetchDecksDownloaded();
  }

  Future<void> fetchDecks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _decks = await getAllDeck('createdAt DESC');
      print('===${_decks}');
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDecksDownloaded() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _decksDownloaded = await getAllDeckDownloaded('createdAt DESC');
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void dispose() {
    super.dispose();
  }
}
