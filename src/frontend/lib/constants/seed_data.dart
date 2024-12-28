import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/services/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> seedDatabaseForDecksControl() async {
  // Create sample decks
  List<DeckModel> sampleDecks = [
    DeckModel(
      id: '1',
      name: 'English Vocabulary',
      description: 'Basic English words and phrases',
      is_published: true,
      deck_cards_count: '5',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    DeckModel(
      id: '2',
      name: 'Math Formulas',
      description: 'Common mathematical formulas',
      is_published: true,
      deck_cards_count: '5',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    DeckModel(
      id: '3',
      name: 'Japanese Hiragana',
      description: 'Basic Japanese characters',
      is_published: true,
      deck_cards_count: '5',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  // Create sample cards for each deck
  Map<String, List<CardModel>> deckCards = {
    '1': [
      CardModel(
        id: '1',
        userId: '1',
        deckId: '1',
        question: 'Hello',
        imageId: '',
        answer: 'Xin chào',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '2',
        userId: '1',
        deckId: '1',
        question: 'Goodbye',
        imageId: '',
        answer: 'Tạm biệt',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '3',
        userId: '1',
        deckId: '1',
        question: 'Thank you',
        imageId: '',
        answer: 'Cảm ơn',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '4',
        userId: '1',
        deckId: '1',
        question: 'Good morning',
        imageId: '',
        answer: 'Chào buổi sáng',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '5',
        userId: '1',
        deckId: '1',
        question: 'Good night',
        imageId: '',
        answer: 'Chúc ngủ ngon',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ],
    '2': [
      CardModel(
        id: '6',
        userId: '1',
        deckId: '2',
        question: 'Area of a circle',
        imageId: '',
        answer: 'A = πr²',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '7',
        userId: '1',
        deckId: '2',
        question: 'Pythagorean theorem',
        imageId: '',
        answer: 'a² + b² = c²',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '8',
        userId: '1',
        deckId: '2',
        question: 'Area of a triangle',
        imageId: '',
        answer: 'A = (b × h) ÷ 2',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '9',
        userId: '1',
        deckId: '2',
        question: 'Circumference of a circle',
        imageId: '',
        answer: 'C = 2πr',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '10',
        userId: '1',
        deckId: '2',
        question: 'Volume of a cube',
        imageId: '',
        answer: 'V = s³',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ],
    '3': [
      CardModel(
        id: '11',
        userId: '1',
        deckId: '3',
        question: 'あ',
        imageId: '',
        answer: 'a',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '12',
        userId: '1',
        deckId: '3',
        question: 'い',
        imageId: '',
        answer: 'i',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '13',
        userId: '1',
        deckId: '3',
        question: 'う',
        imageId: '',
        answer: 'u',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '14',
        userId: '1',
        deckId: '3',
        question: 'え',
        imageId: '',
        answer: 'e',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CardModel(
        id: '15',
        userId: '1',
        deckId: '3',
        question: 'お',
        imageId: '',
        answer: 'o',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ],
  };

  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    // Insert decks into database
    for (var deck in sampleDecks) {
      await insertDeck(deck);
    }

    // Insert cards for each deck
    for (var deckId in deckCards.keys) {
      for (var card in deckCards[deckId]!) {
        await insertCard(card);
      }
    await prefs.setBool('isFirstLaunch', false);
  }

  }

  print("Seed data inserted successfully for decks and cards.");
}
