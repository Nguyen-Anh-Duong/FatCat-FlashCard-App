import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/services/card_service.dart';
import 'package:FatCat/views/screens/intermittent_study_screen.dart';
import 'package:FatCat/views/screens/self_study_screen.dart';
import 'package:flutter/material.dart';

class StudyModeViewModel extends ChangeNotifier {
  final String deckId;
  List<CardModel> _cards = [];
  StudyModeViewModel({required this.deckId});

  List<CardModel> get cards => _cards;

  Future<void> getCards() async {
    final cards = await CardService().getCardsByDeckId(deckId);
    _cards = cards;
    notifyListeners();
  }

  void routeToSelfStudyScreen(BuildContext context) async {
    await getCards();
    print("############# ${_cards}");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelfStudyScreen(cards: _cards)),
    );
  }

  void routeToIntermittentStudyScreen(BuildContext context) async {
    await getCards();
    print("############# ${_cards}");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => IntermittentStudyScreen(cards: _cards)),
    );
  }
}
