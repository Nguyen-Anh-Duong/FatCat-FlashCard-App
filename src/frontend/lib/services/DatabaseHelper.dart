import 'dart:async';

// import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:FatCat/models/user_model.dart';

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
        return db.execute(
            'CREATE TABLE USER(id INTEGER PRIMARY KEY, name TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute('CREATE TABLE USER(id INTEGER PRIMARY KEY, name TEXT)');
        }
        if (oldVersion < 3) {
          db.execute('CREATE TABLE DECK(id INTEGER PRIMARY KEY, user_id INTEGER, name TEXT, description TEXT)');
        }
      },
      version: 3,
    );
    return database!;
  }
}

//User data
Future<int> insertUser(UserModel user) async {
  try{
    Database db = await AppDatabase.getInstance();
    int lastInsertedRow = await db.insert('USER', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
    return lastInsertedRow;
  }catch(ex) {
    print(ex);
    return -1;
  }
}

Future<int> deleteUserById(int id) async{
  try {
    Database db = await AppDatabase.getInstance();
    int numberOfRowEffected= await db.delete('USER', where: "id = ?", whereArgs: [id]);
    return 1;
  }catch(ex) {
    print(ex);
    return -1;
  }
}

Future <List<UserModel>> getAllUser() async {
  Database db = await AppDatabase.getInstance();

  final List<Map<String, Object?>> userMaps = await db.query('USER');

  return [
    for(final {
    'id': id as int,
    'name': name as String,
    } in userMaps)
      UserModel(c_id: id, c_name: name),
  ];
}




