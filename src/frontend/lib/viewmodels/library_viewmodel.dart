import 'package:FatCat/services/deck_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/deck_model.dart';

class LibraryViewModel extends ChangeNotifier {
  final String baseUrl = dotenv.env['BASE_URL']!;
  bool _isLoading = false;
  bool _isConnected = true;
  List<DeckModel> _decks = [];
  String? _error;

  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;
  List<DeckModel> get decks => _decks;
  String? get error => _error;

  LibraryViewModel() {
    fetchDecks();
  }

  Future<void> fetchDecks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      _decks = await DeckService.fetchDecks();
      print('222');
    } catch (e) {
      _error = e.toString();
      _isConnected = false;
    }

    _isLoading = false;
    notifyListeners();
  }
}
