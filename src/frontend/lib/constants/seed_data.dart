import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/models/progress_model.dart';
import 'package:FatCat/models/user_model.dart';
import 'package:FatCat/services/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

void seedDatabase() async {
  Database db = await AppDatabase.getInstance();

  // Insert a sample user
  UserModel sampleUser = UserModel(id: '1', name: 'Sample User');
  await insertUser(sampleUser);

  // Insert a sample deck
  DeckModel sampleDeck = DeckModel(
    id: '1',
    name: 'Sample Deck',
    description: 'A sample deck for testing',
    is_published: true,
    deck_cards_count: '0',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  await insertDeck(sampleDeck);
  print("sampleDeck inserted");

  // Insert sample cards
  CardModel sampleCard1 = CardModel(
    id: '101',
    userId: '1',
    deckId: '1',
    question: 'What is 1+1?',
    imageId: '',
    answer: '2',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  CardModel sampleCard2 = CardModel(
    id: '102',
    userId: '1',
    deckId: '1',
    question: 'What is 2+2?',
    imageId: '',
    answer: '4',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  await insertCard(sampleCard1);
  await insertCard(sampleCard2);

  // Insert a sample progress
  ProgressModel sampleProgress = ProgressModel(
    id: '1',
    userId: '1',
    cardId: '101',
    lastReviewedAt: DateTime.now(),
    reviewCount: '1',
    nextReviewAt: DateTime.now().add(Duration(days: 1)),
  );
  await insertProgress(sampleProgress);

  print("Seed data inserted successfully.");
}
