import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:FatCat/models/user_model.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/models/progress_model.dart';

void vah_test() async {
  WidgetsFlutterBinding.ensureInitialized();
  // User testUser = User(c_id: 1, c_name: 'Vu Anh Huy');
  // // print(join("User : ", testUser.toString()));
  // int i = await insertUser(testUser);

  Database db = await AppDatabase.getInstance();
  print("DB VERSION: " + (await db.getVersion()).toString());

  print(await getAllUser());
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
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute(
              'CREATE TABLE CARD(id TEXT PRIMARY KEY, userId TEXT deckId TEXT, question TEXT, imageId TEXT, answer TEXT, createdAt TEXT, updatedAt TEXT)');
          db.execute(
              'CREATE TABLE PROGRESS(id TEXT PRIMARY KEY, userId TEXT, cardId TEXT, lastReviewedAt TEXT, reviewCount TEXT, nextReviewAt TEXT)');
        }
      },
      version: 2,
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

Future<int> deleteDeckById(int id) async {
  try {
    Database db = await AppDatabase.getInstance();
    int numberOfRowEffected = await db.delete('DECK', where: "id = ?", whereArgs: [id]);
    return 1;
  } catch (ex) {
    return -1;
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
    return lastInsertedRow;
  } catch (ex) {
    return -1;
  }
}

Future<int> deleteCardById(int id) async {
  try {
    Database db = await AppDatabase.getInstance();
    int numberOfRowEffected =
        await db.delete('CARD', where: "id = ?", whereArgs: [id]);
    return 1;
  } catch (ex) {
    return -1;
  }
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
