import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  static Future<void> createDatabase(sql.Database database) async {
    await database.execute(
        'CREATE TABLE balldetails (ballNo INTEGER PRIMARY KEY AUTOINCREMENT, batID TEXT, ballID TEXT, action TEXT, inns INTEGER)');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('polygonCric.db', version: 1,
        onCreate: (sql.Database database, int version) async {
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
    final database = await DatabaseHelper.db();
    return database.query('balldetails', orderBy: "ballNo");
  }

  static Future<List<Map<String, dynamic>>> getItem(String action) async {
    final database = await DatabaseHelper.db();
    return database.query('balldetails',
        where: "action = ?", whereArgs: [action], limit: 2);
  }

  static Future<int> updateItem(
      int ballNo, String action, String batID, String ballID, int inns) async {
    final db = await DatabaseHelper.db();
    final data = {
      'action': action,
      'batID': batID,
      'ballID': ballID,
      'inns': inns
    };
    final result = await db
        .update('balldetails', data, where: "id = ?", whereArgs: [ballNo]);
    return result;
  }

  static Future<void> deleteItem(String action) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete('balldetails', where: 'action = ?', whereArgs: [action]);
    } catch (err) {
      debugPrint('Something wrong: $err');
    }
  }

  static Future<void> deleteTable() async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete('balldetails');
    } catch (err) {
      debugPrint('Something wrong: $err');
    }
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