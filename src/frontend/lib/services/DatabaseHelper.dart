import 'dart:async';

import 'package:FatCat/constants/seed_data.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/models/progress_model.dart';
import 'package:FatCat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void vah_test() async {
  Database db = await AppDatabase.getInstance();
  print("DB VERSION: " + (await db.getVersion()).toString());
}

class AppDatabase {
  static Database? database;

  static Future<Database> getInstance() async {
    database ??= await openDatabase(
      join(await getDatabasesPath(), 'app.db'),
      onCreate: (db, version) {
        db.execute('PRAGMA foreign_keys = ON');
        db.execute(
            'CREATE TABLE USER(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
        db.execute(
            'CREATE TABLE DECK(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, is_published TEXT, deck_cards_count INTEGER, question_language TEXT, answer_language TEXT, category_name TEXT,is_cloned TEXT, createdAt TEXT, updatedAt TEXT)');
        db.execute(
            'CREATE TABLE CARD(id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, deckId INTEGER, question TEXT, imageId TEXT, answer TEXT, createdAt TEXT, updatedAt TEXT, FOREIGN KEY (deckId) REFERENCES DECK(id) ON DELETE CASCADE)');
        db.execute(
            'CREATE TABLE PROGRESS(id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, cardId INTEGER, lastReviewedAt TEXT, reviewCount TEXT, nextReviewAt TEXT, FOREIGN KEY (cardId) REFERENCES CARD(id) ON DELETE CASCADE)');
      },
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          await db.transaction((txn) async {
            await txn.execute('PRAGMA foreign_keys = OFF');

            try {
              // Drop
              await txn.execute('DROP TABLE IF EXISTS PROGRESS');
              await txn.execute('DROP TABLE IF EXISTS CARD');
              await txn.execute('DROP TABLE IF EXISTS DECK');
              await txn.execute('DROP TABLE IF EXISTS USER');

              print('Tables dropped successfully');

              // Create
              await txn.execute(
                  'CREATE TABLE USER(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');

              await txn.execute('''CREATE TABLE DECK(
                id INTEGER PRIMARY KEY AUTOINCREMENT, 
                name TEXT, 
                description TEXT, 
                is_published TEXT, 
                deck_cards_count INTEGER, 
                question_language TEXT, 
                answer_language TEXT, 
                category_name TEXT,
                is_cloned TEXT, 
                createdAt TEXT, 
                updatedAt TEXT
              )''');

              await txn.execute('''CREATE TABLE CARD(
                id INTEGER PRIMARY KEY AUTOINCREMENT, 
                userId INTEGER, 
                deckId INTEGER, 
                question TEXT, 
                imageId TEXT, 
                answer TEXT, 
                createdAt TEXT, 
                updatedAt TEXT, 
                FOREIGN KEY (deckId) REFERENCES DECK(id) ON DELETE CASCADE
              )''');

              await txn.execute('''CREATE TABLE PROGRESS(
                id INTEGER PRIMARY KEY AUTOINCREMENT, 
                userId INTEGER, 
                cardId INTEGER, 
                lastReviewedAt TEXT, 
                reviewCount TEXT, 
                nextReviewAt TEXT, 
                FOREIGN KEY (cardId) REFERENCES CARD(id) ON DELETE CASCADE
              )''');

              await txn.execute('PRAGMA foreign_keys = ON');

              print('Tables recreated successfully');
            } catch (e) {
              print('Error during upgrade: $e');
              rethrow; // Rethrow to trigger rollback
            }
          });
        }
      },
      version: 4,
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
    print("INSERT DECK: ");
    Database db = await AppDatabase.getInstance();
    int lastInsertedRow = await db.insert(
      'DECK',
      deck.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('okk');
    return lastInsertedRow;
  } catch (ex) {
    return -1;
  }
}

Future<int> deleteDeck(String deckId) async {
  try {
    Database db = await AppDatabase.getInstance();
    int numberOfRowEffected =
        await db.delete('DECK', where: "id = ?", whereArgs: [deckId]);
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
          'id': id as int,
          'name': name as String,
          'description': description as String,
          'is_published': is_published as String,
          'deck_cards_count': deck_cards_count as int,
          'createdAt': createdAt as String,
          'updatedAt': updatedAt as String,
        } in deckMaps)
      DeckModel(
          id: id.toString(),
          name: name,
          description: description,
          is_published: is_published.toBoolean(),
          deck_cards_count: deck_cards_count.toString(),
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt))
  ];
}

Future<List<DeckModel>> getAllDeckDownloaded(String orderBy) async {
  Database db = await AppDatabase.getInstance();
  final List<Map<String, Object?>> deckMaps = await db.query('DECK',
      where: 'is_cloned = ?', whereArgs: ['true'], orderBy: orderBy);
  return [
    for (final {
          'id': id as int,
          'name': name as String,
          'description': description as String,
          'is_published': is_published as String,
          'deck_cards_count': deck_cards_count as int,
          'createdAt': createdAt as String,
          'updatedAt': updatedAt as String,
        } in deckMaps)
      DeckModel(
          id: id.toString(),
          name: name,
          description: description,
          is_published: is_published.toBoolean(),
          deck_cards_count: deck_cards_count.toString(),
          createdAt: DateTime.parse(createdAt),
          updatedAt: DateTime.parse(updatedAt))
  ];
}

///Update the deck that has the same DeckModel's id
Future<void> updateDeck(String deckId, Map<String, String> deckData) async {
  try {
    Database db = await AppDatabase.getInstance();
    deckData['updatedAt'] = DateTime.now().toIso8601String();

    await db.update('DECK', deckData, where: 'id = ?', whereArgs: [deckId]);
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
    // await updateDeck(deck);

    return lastInsertedRow;
  } catch (ex) {
    return -1;
  }
}

Future<void> increaseCountByOne(String deckId) async {
  List<DeckModel> decks = await getDeckWithId(deckId);
  DeckModel deck = decks[0];

  deck.deck_cards_count = (int.parse(deck.deck_cards_count) + 1).toString();
  await updateDeckByDeckModel(deck);
}

Future<void> decreaseCountByOne(String deckId) async {
  List<DeckModel> decks = await getDeckWithId(deckId);
  DeckModel deck = decks[0];

  deck.deck_cards_count = (int.parse(deck.deck_cards_count) - 1).toString();
  await updateDeckByDeckModel(deck);
}

Future<void> updateDeckByDeckModel(DeckModel deck) async {
  try {
    Database db = await AppDatabase.getInstance();

    // Update the deck with data from DeckModel
    await db.update(
      'DECK',
      deck.toMap(),
      where: 'id = ?',
      whereArgs: [deck.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  } catch (ex) {
    print('Error updating deck by model: $ex');
    throw ex;
  }
}

Future<int> deleteCard(String cardId) async {
  try {
    Database db = await AppDatabase.getInstance();
    int numberOfRowEffected =
        await db.delete('CARD', where: "id = ?", whereArgs: [cardId]);

    return 1;
  } catch (ex) {
    print(ex);
    return -1;
  }
}

Future<bool> createDeckWithCards({
  required Map<String, String> deckData,
  required List<Map<String, String>> cards,
}) async {
  try {
    Database db = await AppDatabase.getInstance();

    return await db.transaction((txn) async {
      // 1Tạo deck mới
      final deck = {
        'name': deckData['name'],
        'description': deckData['description'],
        'deck_cards_count': cards.length.toString(),
        'is_published': 'true',
        'question_language': deckData['question_language'] ?? 'en',
        'answer_language': deckData['answer_language'] ?? 'en',
        'category_name': deckData['category_name'] ?? 'unknown',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      print('===');
      final deckId = await txn.insert(
        'DECK',
        deck,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("OKK deckId:: $deckId");

      for (var cardData in cards) {
        final card = {
          'userId': '1',
          'deckId': deckId,
          'question': cardData['question'] ?? '',
          'answer': cardData['answer'] ?? '',
          'imageId': '',
          'createdAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        };

        await txn.insert(
          'CARD',
          card,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      return true;
    });
  } catch (e) {
    print('Error creating deck with cards: $e');
    return false;
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
Future<List<CardModel>> getCard(String deckId) async {
  Database db = await AppDatabase.getInstance();
  final List<Map<String, dynamic>> cardMaps =
      await db.query('CARD', where: 'deckId = ?', whereArgs: [deckId]);

  return cardMaps
      .map((map) => CardModel(
            id: map['id'].toString(),
            userId: map['userId'].toString(),
            deckId: map['deckId'].toString(),
            question: map['question'].toString(),
            imageId: map['imageId']?.toString() ?? '',
            answer: map['answer'].toString(),
            createdAt: DateTime.parse(map['createdAt'].toString()),
            updatedAt: DateTime.parse(map['updatedAt'].toString()),
          ))
      .toList();
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
