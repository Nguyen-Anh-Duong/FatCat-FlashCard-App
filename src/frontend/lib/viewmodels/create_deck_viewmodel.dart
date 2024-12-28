import 'package:FatCat/models/card_edit_model.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/services/deck_service.dart';
import 'package:flutter/material.dart';
import 'package:FatCat/services/DatabaseHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateOrUpdateDeckViewModel extends ChangeNotifier {
  final String? deckId;
  final String? userId; //ng tao deck
  final DeckModel? initialDeck;
  DeckModel? updatedDeck;
  final List<CardModel>? initialCards;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<CardEditModel> cards = [];
  String? selectedFrontLanguage = 'English';
  String? selectedBackLanguage = 'English';
  void setFrontLanguage(String language) {
    selectedFrontLanguage = language;
    notifyListeners();
  }

  void setBackLanguage(String language) {
    selectedBackLanguage = language;
    notifyListeners();
  }

  String languageToCode(String language) {
    if (language == 'Tiếng Việt') {
      return 'vi';
    } else if (language == 'English') {
      return 'en-US';
    } else if (language == 'Japanese') {
      return 'ja';
    } else if (language == 'Tiếng Trung') {
      return 'zh-CN';
    } else {
      return 'en-US';
    }
  }

  String codeToLanguage(String code) {
    if (code == 'vi') {
      return 'Tiếng Việt';
    } else if (code == 'en-US') {
      return 'English';
    } else if (code == 'ja') {
      return 'Japanese';
    } else if (code == 'zh-CN') {
      return 'Tiếng Trung';
    } else if (code == 'en-US') {
      return 'English';
    } else {
      return 'English';
    }
  }

  CreateOrUpdateDeckViewModel({
    this.deckId,
    this.userId,
    this.initialDeck,
    this.initialCards,
  }) {
    if (initialDeck != null) {
      // Initialize controllers with existing deck data
      titleController.text = initialDeck!.name;
      descriptionController.text = initialDeck!.description;
      selectedFrontLanguage =
          codeToLanguage(initialDeck!.question_language ?? 'en-US');
      selectedBackLanguage =
          codeToLanguage(initialDeck!.answer_language ?? 'en-US');
      notifyListeners();
    }

    Future.delayed(const Duration(milliseconds: 450));
    if (initialCards != null) {
      // Convert CardModel to CardEditModel
      cards = initialCards!
          .map((card) => CardEditModel(
                id: card.id,
                question: card.question,
                answer: card.answer,
                deckId: card.deckId,
                createdAt: card.createdAt,
                updatedAt: card.updatedAt,
              ))
          .toList();
    }

    if (deckId != null && initialDeck == null) {
      loadDataExistedDeck();
    }
  }

  Future<void> loadDataExistedDeck() async {
    try {
      final List<DeckModel> decks = await getDeckWithId(deckId!);
      if (decks.isNotEmpty) {
        final deck = decks[0];
        titleController.text = deck.name;
        descriptionController.text = deck.description;
        selectedFrontLanguage =
            codeToLanguage(deck.question_language ?? 'en-US');
        selectedBackLanguage = codeToLanguage(deck.answer_language ?? 'en-US');

        final cardsList = await getCard(deckId!);
        cards = cardsList
            .map((card) => CardEditModel(
                  question: card.question,
                  answer: card.answer,
                  deckId: card.deckId,
                  createdAt: card.createdAt,
                  updatedAt: card.updatedAt,
                ))
            .toList();

        notifyListeners();
      }
    } catch (e) {
      print('Error loading deck: $e');
    }
  }

  void addCard() {
    final newCard = CardEditModel(
      question: '',
      answer: '',
      deckId: deckId ?? '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    cards = [...cards, newCard];
    notifyListeners();
  }

  void removeCard(int index) {
    if (index >= 0 && index < cards.length) {
      cards = List.from(cards)..removeAt(index);
      notifyListeners();
    }
  }

  void updateCard(int index, CardEditModel card) {
    if (index < 0 || index >= cards.length) return;
    if (cards[index] == card) return;
    cards = [...cards]..[index] = card;
    notifyListeners();
  }

  Future<DeckModel?> saveDeck() async {
    if (titleController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Tiêu đề không được để trống',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      throw Exception('Tiêu đề không được để trống');
    }
    final deckData = {
      'name': titleController.text,
      'description': descriptionController.text,
      'deck_cards_count': cards.length.toString(),
      'question_language': languageToCode(selectedFrontLanguage ?? 'English'),
      'answer_language': languageToCode(selectedBackLanguage ?? 'English'),
    };
    if (deckId == null) {
      print('====Create deck====');

      // Tạo danh sách cards
      final cardsList = cards
          .map((card) => {
                'question': card.question,
                'answer': card.answer,
              })
          .toList();
      final success = await createDeckWithCards(
        deckData: deckData,
        cards: cardsList,
      );

      if (!success) {
        throw Exception('Không thể lưu deck và cards');
      }

      Fluttertoast.showToast(
        msg: 'Tạo bộ thẻ thành công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      try {
        print('====Update deck====');
        deckData['deck_cards_count'] = cards.length.toString();

        await updateDeck(deckId!, deckData);

        final existingCards = await getCard(deckId!);

        for (var card in existingCards) {
          await deleteCard(card.id!);
        }

        for (var card in cards) {
          final cardData = CardModel(
            userId: '1',
            deckId: deckId!,
            question: card.question,
            answer: card.answer,
            imageId: '',
            createdAt: card.createdAt ?? DateTime.now(),
            updatedAt: DateTime.now(),
          );
          await insertCard(cardData);
        }
        notifyListeners();
        Fluttertoast.showToast(
          msg: 'Cập nhật bộ thẻ thành công',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        return updatedDeck;
      } catch (e) {
        throw Exception('Không thể cập nhật deck và cards: $e');
      }
    }
  }

  Future<DeckModel?> saveDeckToServer(String classId) async {
    if (titleController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Tiêu đề không được để trống',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      throw Exception('Tiêu đề không được để trống');
    }
    final deckTemp = DeckModel(
      id: '',
      question_language: languageToCode(selectedFrontLanguage ?? 'English'),
      answer_language: languageToCode(selectedBackLanguage ?? 'English'),
      name: titleController.text,
      description: descriptionController.text,
      is_published: false,
      deck_cards_count: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    if (deckId == null) {
      print('====Create deck====');
      final List<CardModel> cardsList = cards
          .map((card) => CardModel(
              deckId: '',
              question: card.question,
              answer: card.answer,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now()))
          .toList();
      print('2====Create deck====');

      final success =
          await DeckService.createDeckToServer(classId, deckTemp, cardsList);

      if (!success) {
        throw Exception('Không thể lưu deck và cards');
      }

      Fluttertoast.showToast(
        msg: 'Tạo bộ thẻ thành công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    } else {
      deckTemp.id = deckId;
      print('====Update deck====');
      deckTemp.user_id = userId ?? '';
      print('user_id');
      List<CardModel> cardTemp = [];
      for (var card in cards) {
        print('card ${card.question} ${card.id}');
        final cardData = CardModel(
          id: card.id ?? '',
          userId: '1',
          deckId: deckId!,
          question: card.question,
          answer: card.answer,
          imageId: '',
          createdAt: card.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
        );
        cardTemp.add(cardData);
      }
      await DeckService.updateDeckToServer(classId, deckTemp, cardTemp);
      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Cập nhật bộ thẻ thành công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return updatedDeck;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
