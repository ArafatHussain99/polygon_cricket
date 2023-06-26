import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  static Future<void> createDatabase(Database database) async {
    await database.execute(
        'CREATE TABLE balldetails (ballNo INTEGER PRIMARY KEY AUTOINCREMENT, batID TEXT, ballID TEXT, action TEXT, inns INTEGER)');
  }

  static Future<Database> db() async {
    return openDatabase('balldetails.db', version: 1,
        onCreate: (Database database, int version) async {
      await createDatabase(database);
    });
  }

  static Future<int> createItem(
      String batID, String ballID, String action, int inns) async {
    final db = await DatabaseHelper.db();

    final data = {
      'batID': batID,
      'ballID': ballID,
      'action': action,
      'inns': inns
    };
    final id = await db.insert('balldetails', data);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final database = await db();
    return database.query('balldetails', orderBy: "ballNo");
  }

  static Future<List<Map<String, dynamic>>> getItem(String action) async {
    final database = await db();
    return database.query('balldetails',
        where: "action = ?", whereArgs: [action], limit: 3);
  }
}


  // var db = await database();
  // Future<Database> get database async {
  //   if (_database != null) {
  //     return _database;
  //   }
  //   _database = await initializeDatabase();
  //   return _database;
  // }

  // Future<Database> initializeDatabase() async {
  //   String ditectory = await getDatabasesPath();
  //   String path = join(ditectory, 'my_database.db');

  //   return await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: _createDatabase,
  //   );
  // }
  // Future<int> insertData(
  //     String batID, String ballID, String action, int inns) async {
  //   Database db = await database;
  //   Map<String, dynamic> data = {
  //     'batID': batID,
  //     'ballID': ballID,
  //     'action': action,
  //     'inns': inns
  //   };
  //   return await db.insert('my_table', data);
  // }

  // Future<List<Map<String, dynamic>>> getAllData() async {
  //   Database db = await database;
  //   return await db.query('my_table');
  // }

  // Future<List<Map<String, dynamic>>> searchData(int inns) async {
  //   Database db = await database;

  //   // Search for data with the given name
  //   return await db.query(
  //     'my_table',
  //     where: 'inns = ?',
  //     whereArgs: [inns],
  //   );
  // }