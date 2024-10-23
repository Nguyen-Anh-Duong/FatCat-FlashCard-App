import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:FatCat/models/card_model.dart';
import 'dart:async';

class IntermittentStudyViewModel extends ChangeNotifier {
  final List<CardModel> cards;
  late CardSwiperController cardSwiperController;
  late List<GlobalKey<FlipCardState>> cardKeys;

  final Map<String, int> _detailedAnswers = {
    "Dễ": 0,
    "Tốt": 0,
    "Khó": 0,
    "Học lại": 0
  };
  int _studiedCards = 0;
  bool _showAnswer = false;
  Color? _currentBorderColor;
  Timer? _borderTimer;
  bool isCurrentCardAnswered = false;
  int _currentIndex = 0;

  int get studiedCards => _studiedCards;
  int get totalCards => cards.length;
  bool get showAnswer => _showAnswer;
  Color? get currentBorderColor => _currentBorderColor;
  Map<String, int> get detailedAnswers => _detailedAnswers;

  IntermittentStudyViewModel({required this.cards}) {
    cardSwiperController = CardSwiperController();
    cardKeys = List.generate(cards.length, (_) => GlobalKey<FlipCardState>());
  }

  void toggleShowAnswer() {
    _showAnswer = !showAnswer;
    notifyListeners();
  }

  void flipCurrentCard(BuildContext context) {
    cardKeys[_currentIndex].currentState?.toggleCard();
  }

  void answerCard(int difficulty) {
    if (!isCurrentCardAnswered) {
      isCurrentCardAnswered = true;
      _studiedCards++;
      _showAnswer = false;
      switch (difficulty) {
        case 0:
          _detailedAnswers["Học lại"] = _detailedAnswers["Học lại"]! + 1;
          cardSwiperController.swipe(CardSwiperDirection.left);
          break;
        case 1:
          _detailedAnswers["Khó"] = _detailedAnswers["Khó"]! + 1;
          cardSwiperController.swipe(CardSwiperDirection.left);
          break;
        case 2:
          _detailedAnswers["Tốt"] = _detailedAnswers["Tốt"]! + 1;
          cardSwiperController.swipe(CardSwiperDirection.right);
          break;
        case 3:
          _detailedAnswers["Dễ"] = _detailedAnswers["Dễ"]! + 1;
          cardSwiperController.swipe(CardSwiperDirection.right);
          break;
      }
      notifyListeners();
    }
  }

  bool onSwipe(
      int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    // Reset isCurrentCardAnswered when swiping to a new card
    isCurrentCardAnswered = false;
    // You can add logic here if needed when a card is swiped
    if (currentIndex != null) {
      _currentIndex = currentIndex;
      _showAnswer = false;
      notifyListeners();
    }
    return true;
  }

  void flipCard(int index) {
    cardKeys[index].currentState?.toggleCard();
  }

  void setBorderColor(Color color) {
    _currentBorderColor = color;
    notifyListeners();

    _borderTimer?.cancel();
    _borderTimer = Timer(const Duration(milliseconds: 400), () {
      _currentBorderColor = null;
      notifyListeners();
    });
  }

  bool get isStudyCompleted => studiedCards == cards.length;

  @override
  void dispose() {
    _borderTimer?.cancel();
    super.dispose();
  }
}
