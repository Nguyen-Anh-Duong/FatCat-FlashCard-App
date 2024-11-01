// ignore_for_file: avoid_print

import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/services/connectivity_service.dart';
import 'package:FatCat/services/deck_service.dart';
import 'package:FatCat/views/screens/category_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class HomeViewModel extends ChangeNotifier {
  final DeckService deckService = DeckService();
  List<DeckModel> _decks = [];

  List<DeckModel> get decks => _decks;

  Future<void> openCategoryScreen(BuildContext context, String category) async {
    try {
      List<DeckModel> decks = await deckService.getDecks(category);
      _decks = decks;
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

  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  HomeViewModel() {
    _checkInitialConnectivity();
    _listenToConnectivityChanges();
  }

  Future<void> _checkInitialConnectivity() async {
    final results = await _connectivityService.checkConnectivity();
    await _updateConnectionStatus(results);
  }

  void _listenToConnectivityChanges() {
    _connectivityService.connectivityStream.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    final hasNetworkConnection = results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi);

    if (hasNetworkConnection) {
      try {
        // Thử kết nối đến một địa chỉ internet để kiểm tra
        final response = await InternetAddress.lookup('google.com');
        _isConnected = response.isNotEmpty && response[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        _isConnected = false;
      }
    } else {
      _isConnected = false;
    }

    notifyListeners();
  }
}
