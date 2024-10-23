// lib/view_models/self_study_view_model.dart
import 'package:FatCat/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SelfStudyViewModel extends ChangeNotifier {
  final List<CardModel> cards;
  final List<GlobalKey<FlipCardState>> cardKeys;
  int _orangeScore = 0;
  int _greenScore = 0;
  int _progress = 0;
  int _currentIndex = 0;
  final CardSwiperController cardSwiperController = CardSwiperController();
  List<String> _scoreHistory = [];
  double _ttsVolume = 1.0; // Default volume

  SelfStudyViewModel(this.cards)
      : cardKeys = List.generate(
          cards.length,
          (_) => GlobalKey<FlipCardState>(),
        );

  int get orangeScore => _orangeScore;
  int get greenScore => _greenScore;
  int get cardsLength => cards.length;
  int get progress => _progress;
  int get currentIndex => _currentIndex;
  double get ttsVolume => _ttsVolume;

  void incrementOrangeScore() {
    _orangeScore++;
    _progress++;
    _scoreHistory.add('orange');
    notifyListeners();
  }

  void incrementGreenScore() {
    _greenScore++;
    _progress++;
    _scoreHistory.add('green');
    print("====");
    notifyListeners();
  }

  void flipCard(int index) {
    cardKeys[index].currentState?.toggleCard();
    notifyListeners();
  }

  void goToPreviousCard() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _progress--;
      cardSwiperController.moveTo(_currentIndex);

      String latestScore = _scoreHistory.removeLast();
      if (latestScore == 'orange') {
        _orangeScore--;
      } else if (latestScore == 'green') {
        _greenScore--;
      }

      notifyListeners();
    } else if (_currentIndex == 0) {
      _progress = 0;
      _orangeScore = 0;
      _greenScore = 0;
      _scoreHistory = [];
      notifyListeners();
    }
  }

  bool onSwipe(
      int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.right) {
      incrementGreenScore();
    } else if (direction == CardSwiperDirection.left) {
      incrementOrangeScore();
    } else {
      return false;
    }
    if (currentIndex != null) {
      updateCurrentIndex(currentIndex);
    }
    return true;
  }

  void nextCard() {}
  void updateCurrentIndex(int? newIndex) {
    if (newIndex != null) {
      _currentIndex = newIndex;
      notifyListeners();
    }
  }

  void shuffleCards() {
    cards.shuffle();
    notifyListeners();
  }

  void setVolume(double volume) {
    _ttsVolume = volume;
    notifyListeners();
  }

  void updateTtsVolume(double temp, double newValue) {
    temp = newValue;
    notifyListeners();
  }

  bool get isStudyCompleted => _progress == cards.length;
}
