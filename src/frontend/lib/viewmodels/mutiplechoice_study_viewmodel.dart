import 'package:FatCat/models/card_model.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class MultipleChoiceStudyViewModel extends ChangeNotifier {
  final List<CardModel> cards;
  late Map<String, List<String>> questionAnswers;
  int _studiedCards = 0;

  MultipleChoiceStudyViewModel({required this.cards}) {
    questionAnswers = _generateQuestionAnswers();
  }

  Map<String, List<String>> _generateQuestionAnswers() {
    final Map<String, List<String>> result = {};
    final Random random = Random();

    // Tạo pool các câu trả lời từ tất cả các cards
    final List<String> answerPool = cards.map((card) => card.answer).toList();

    for (var card in cards) {
      List<String> answers = [card.answer];
      List<String> remainingAnswers = List.from(answerPool)
        ..remove(card.answer);
      remainingAnswers.shuffle(random);

      answers.addAll(remainingAnswers.take(3));
      while (answers.length < 4) {
        answers.add(""); // Thêm chuỗi rỗng ếu k đủ he
      }

      answers.shuffle(random);
      result[card.question] = answers;
    }

    return result;
  }

  String get currentQuestion => cards[_studiedCards].question;
  List<String> get currentAnswers => questionAnswers[currentQuestion] ?? [];
  bool get isStudyCompleted => _studiedCards >= cards.length;
  int get studiedCards => _studiedCards;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;
  Map<String, bool?> answerStates =
      {}; // null: not selected, true: correct, false: wrong
  bool canProceed = false;

  CardModel get currentCard => cards[_studiedCards];

  void checkAnswer(String answer) {
    if (canProceed) {
      moveToNextQuestion();
      return;
    }

    bool isCorrect = answer == currentCard.answer;
    answerStates[answer] = isCorrect;

    if (isCorrect) {
      _correctAnswers++;
    } else {
      _wrongAnswers++;
    }

    canProceed = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 600), () {
      moveToNextQuestion();
    });
  }

  void moveToNextQuestion() {
    answerStates.clear();
    canProceed = false;
    _studiedCards++;
    notifyListeners();
  }
}
