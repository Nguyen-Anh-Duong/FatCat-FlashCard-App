import 'dart:async';

import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/models/progress_model.dart';
import 'package:FatCat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void vah_test() async {
  WidgetsFlutterBinding.ensureInitialized();
  // User testUser = User(c_id: 1, c_name: 'Vu Anh Huy');
  // // print(join("User : ", testUser.toString()));
  // int i = await insertUser(testUser);

  Database db = await AppDatabase.getInstance();
  print("DB VERSION: " + (await db.getVersion()).toString());

  db.execute('DELETE FROM DECK');
  db.execute('DELETE FROM CARD');

  DeckModel dummyDeck = DeckModel(
      id: '1',
      name: 'number',
      description: '',
      is_published: false,
      deck_cards_count: '0',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  await insertDeck(dummyDeck);

  CardModel dummyCard1 = CardModel(
      id: '100',
      userId: '1',
      deckId: '1',
      question: '1',
      imageId: '',
      answer: '1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  CardModel dummyCard2 = CardModel(
      id: '200',
      userId: '1',
      deckId: '1',
      question: '1',
      imageId: '',
      answer: '1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  await insertCard(dummyCard1);
  await insertCard(dummyCard2);

  // print(await getDeckWithId('1'));
  // print(await getCard(dummyDeck));
}

class AppDatabase {
  static Database? database;

  static Future<Database> getInstance() async {
    database ??= await openDatabase(
      join(await getDatabasesPath(), 'app.db'),
      onCreate: (db, version) {
        db.execute('CREATE TABLE USER(id TEXT PRIMARY KEY, name TEXT)');
        db.execute(
            'CREATE TABLE DECK(id TEXT PRIMARY KEY, name TEXT, description TEXT, is_published TEXT, deck_cards_count INTEGER, createdAt TEXT, updatedAt TEXT)');
        db.execute(
            'CREATE TABLE CARD(id TEXT PRIMARY KEY, userId TEXT, deckId TEXT, question TEXT, imageId TEXT, answer TEXT, createdAt TEXT, updatedAt TEXT)');
        db.execute(
            'CREATE TABLE PROGRESS(id TEXT PRIMARY KEY, userId TEXT, cardId TEXT, lastReviewedAt TEXT, reviewCount TEXT, nextReviewAt TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {},
      version: 1,
    );
    return database!;
  }
}

//User data
Future<int> insertUser(UserModel user) async {
  try {
    Database db = await AppDatabase.getInstance();
    int lastInsertedRow = await db.insert(
      'USER',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return lastInsertedRow;
  } catch (ex) {
    return -1;
  }
}

Future<int> deleteUserById(int id) async {
  try {
    Database db = await AppDatabase.getInstance();
    int numberOfRowEffected =
        await db.delete('USER', where: "id = ?", whereArgs: [id]);
    return 1;
  } catch (ex) {
    return -1;
  }
}

Future<List<UserModel>> getAllUser() async {
  Database db = await AppDatabase.getInstance();

  final List<Map<String, Object?>> userMaps = await db.query('USER');

  return [
    for (final {
          'id': id as String,
          'name': name as String,
        } in userMaps)
      UserModel(id: id, name: name),
  ];
}

//Deck data
Future<int> insertDeck(DeckModel deck) async {
  try {
    Database db = await AppDatabase.getInstance();
    int lastInsertedRow = await db.insert(
      'DECK',
      deck.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return lastInsertedRow;
  } catch (ex) {
    return -1;
  }
}

Future<int> deleteDeck(DeckModel deck) async {
  try {
    Database db = await AppDatabase.getInstance();
    int numberOfRowEffected =
        await db.delete('DECK', where: "id = ?", whereArgs: [deck.id]);
    return 1;
  } catch (ex) {
    return -1;
  }
}

Future<List<DeckModel>> getDeckWithId(String id) async {
  Database db = await AppDatabase.getInstance();
  final List<Map<String, Object?>> deckMaps =
      await db.query('DECK', where: 'id = ?', whereArgs: [id]);
  return [
    for (final {
          'id': id as String,
          'name': name as String,
          'description': description as String,
          'is_published': is_published as String,
          'deck_cards_count': deck_cards_count as int,
          'createdAt': createdAt as String,
          'updatedAt': updatedAt as String,
        } in deckMaps)
      DeckModel(
          id: id,
          name: name,
          description: description,
          is_published: is_published.toBoolean(),
          deck_cards_count: deck_cards_count.toString(),
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt))
  ];
}

Future<List<DeckModel>> getAllDeck(String orderBy) async {
  Database db = await AppDatabase.getInstance();
  final List<Map<String, Object?>> deckMaps =
  await db.query('DECK', orderBy: orderBy);
  return [
    for (final {
    'id': id as String,
    'name': name as String,
    'description': description as String,
    'is_published': is_published as String,
    'deck_cards_count': deck_cards_count as int,
    'createdAt': createdAt as String,
    'updatedAt': updatedAt as String,
    } in deckMaps)
      DeckModel(
          id: id,
          name: name,
          description: description,
          is_published: is_published.toBoolean(),
          deck_cards_count: deck_cards_count.toString(),
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt))
  ];
}

///Update the deck that has the same DeckModel's id
Future<void> updateDeck(DeckModel deck) async {
  try {
    Database db = await AppDatabase.getInstance();
    deck.updatedAt = DateTime.now();

    await db
        .update('DECK', deck.toMap(), where: 'id = ?', whereArgs: [deck.id]);
  } catch (ex) {
    print(ex);
  }
}

//Card data
Future<int> insertCard(CardModel card) async {
  try {
    Database db = await AppDatabase.getInstance();
    int lastInsertedRow = await db.insert(
      'CARD',
      card.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    List<DeckModel> decks = await getDeckWithId(card.deckId);
    DeckModel deck = decks[0];

    deck.deck_cards_count = (int.parse(deck.deck_cards_count) + 1).toString();
    await updateDeck(deck);

    return lastInsertedRow;
  } catch (ex) {
    return -1;
  }
}

Future<int> deleteCard(CardModel card) async {
  try {
    Database db = await AppDatabase.getInstance();
    int numberOfRowEffected =
        await db.delete('CARD', where: "id = ?", whereArgs: [card.id]);

    List<DeckModel> decks = await getDeckWithId(card.deckId);
    DeckModel deck = decks[0];

    deck.deck_cards_count = (int.parse(deck.deck_cards_count) - 1).toString();
    await updateDeck(deck);

    return 1;
  } catch (ex) {
    print(ex);
    return -1;
  }
}

///Update the card that has the same CardModel's id
Future<void> updateCard(CardModel card) async {
  try {
    Database db = await AppDatabase.getInstance();
    await db
        .update('CARD', card.toMap(), where: 'id = ?', whereArgs: [card.id]);
  } catch (ex) {
    print(ex);
  }
}

///Get card with DeckModel
Future<List<CardModel>> getCard(DeckModel deck) async {
  Database db = await AppDatabase.getInstance();
  final List<Map<String, Object?>> cardMaps =
      await (db.query('CARD', where: 'deckId = ?', whereArgs: [deck.id]));
  return [
    for (final {
          'id': id as String,
          'userId': userId as String,
          'deckId': deckId as String,
          'question': question as String,
          'imageId': imageId as String,
          'answer': answer as String,
          'createdAt': createdAt as String,
          'updatedAt': updatedAt as String,
        } in cardMaps)
      CardModel(
          id: id,
          userId: userId,
          deckId: deckId,
          question: question,
          imageId: imageId,
          answer: answer,
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt))
  ];
}

//Progress Data
Future<int> insertProgress(ProgressModel progress) async {
  try {
    Database db = await AppDatabase.getInstance();
    int lastInsertedRow = await db.insert(
      'PROGRESS',
      progress.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return lastInsertedRow;
  } catch (ex) {
    return -1;
  }
}

extension on String {
  bool toBoolean() {
    if (this.toLowerCase() == "true" || this.toLowerCase() == "1")
      return true;
    else
      return false;
  }
}
