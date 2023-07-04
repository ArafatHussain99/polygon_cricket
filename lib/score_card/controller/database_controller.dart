import 'dart:io';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // static Future<void> createDatabase(sql.Database database) async {
  //   print('creating database');
  //   await database.execute(
  //       '''CREATE TABLE balldetails (ballNo INTEGER PRIMARY KEY AUTOINCREMENT, batID TEXT, ballID TEXT, action TEXT, inns INTEGER)''');
  //   print('done creating database');
  // }
  late sql.Database db;
  static Future<sql.Database> open() async {
    return sql.openDatabase('polygonCric.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print('creating new table');
      await database.execute(
          '''CREATE TABLE IF NOT EXISTS balldetails (ballNo INTEGER PRIMARY KEY AUTOINCREMENT, batID TEXT, ballID TEXT, action TEXT, inns INTEGER)''');
    });
  }

  static Future<int> createItem(
      String batID, String ballID, String action, int inns) async {
    final db = await DatabaseHelper.open();

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
    final database = await DatabaseHelper.open();
    return database.query('balldetails', orderBy: "ballNo");
  }

  static Future<List<Map<String, dynamic>>> getItem(String action) async {
    final database = await DatabaseHelper.open();
    return database.query('balldetails',
        where: "action = ?", whereArgs: [action], limit: 2);
  }

  static Future<int> updateItem(
      int ballNo, String action, String batID, String ballID, int inns) async {
    final db = await DatabaseHelper.open();
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
    final db = await DatabaseHelper.open();
    try {
      await db.delete('balldetails', where: 'action = ?', whereArgs: [action]);
    } catch (err) {
      debugPrint('Something wrong: $err');
    }
  }

  static Future<void> deleteTable() async {
    final db = await DatabaseHelper.open();
    try {
      await db.execute('DROP TABLE IF EXISTS balldetails');
    } catch (err) {
      debugPrint('Something wrong: $err');
    }
  }

  static Future<void> deleteDatabaseFile() async {
    final db = await DatabaseHelper.open();
    // Get the directory where the database file is located
    // Directory directory = await getApplicationDocumentsDirectory();
    // String path = directory.path + '/polygonCric.db';
    String databasePath = await getDatabasesPath();
    String databaseName = 'polygonCric.db';
    String path = '$databasePath/$databaseName';
    // Check if the database file exists
    bool exists = await databaseExists(path);
    if (exists) {
      // Close any open connections to the database
      await db.close();

      // Delete the database file
      await deleteDatabase(path);
    }
  }

  static Future<int> version() async {
    final db = await DatabaseHelper.open();
    return db.getVersion();
  }

  static Future<int> getTotalOvers(int inns) async {
    Database database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where:
          'inns = ? AND (action = ? OR action = ? OR action = ? OR action = ? OR action = ?)',
      whereArgs: [inns, '1', '2', '4', 'out', '6'],
    );

    return result.length;
  }

  static Future<int> getfoursScored(String batID, int inns) async {
    Database database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'batID = ? AND action = ? AND inns = ?',
      whereArgs: [batID, '4', inns],
    );

    return result.length;
  }

  static Future<int> getSixessScored(String batID, int inns) async {
    Database database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'batID = ? AND action = ? AND inns = ?',
      whereArgs: [batID, '6', inns],
    );

    return result.length;
  }

  static Future<int> batsmansTotalRunPerInns(String batID, int inns) async {
    Database database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'batID = ? AND inns = ?',
      whereArgs: [batID, inns],
    );
    int totalRun = 0;
    for (Map<String, dynamic> action in result) {
      if (action['action'] == '1') {
        totalRun += 1;
      }
      if (action['action'] == '2') {
        totalRun += 2;
      }
      if (action['action'] == '4') {
        totalRun += 4;
      }
      if (action['action'] == '6') {
        totalRun += 6;
      }
      if (action['action'] == '-5') {
        totalRun -= 5;
      }
    }

    return totalRun;
  }

  static Future<int> batsmansBallsFacedPerInns(String batID, int inns) async {
    Database database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'batID = ? AND inns = ?',
      whereArgs: [batID, inns],
    );
    return result.length;
  }

  static Future<String> batsmansStrikeRatePerInns(
      String batID, int inns) async {
    int ball = await batsmansBallsFacedPerInns(batID, inns);
    if (ball == 0) {
      return '0.00';
    }
    int runs = await batsmansTotalRunPerInns(batID, inns);
    double strikeRate = (runs / ball) * 100;
    return strikeRate.toStringAsFixed(0);
  }

  static Future<int> getTotalTeamRun(int inns) async {
    Database database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'inns = ?',
      whereArgs: [inns],
    );
    int totalRun = 0;
    for (Map<String, dynamic> action in result) {
      if (action['action'] == '1') {
        totalRun += 1;
      }
      if (action['action'] == '2') {
        totalRun += 2;
      }
      if (action['action'] == '4') {
        totalRun += 4;
      }
      if (action['action'] == '6') {
        totalRun += 6;
      }
      if (action['action'] == '-5') {
        totalRun -= 5;
      }
      if (action['action'] == 'WD') {
        totalRun += 1;
      }
    }

    return totalRun;
  }

  static Future<int> getTotalTeamWic(int inns) async {
    Database database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'inns = ? AND action = ?',
      whereArgs: [inns, 'out'],
    );
    return result.length;
  }

  static Future<List<String>> getUniqueBowlerNames() async {
    Database database = await openDatabase('polygonCric.db');

    // Fetch all data from the table
    List<Map<String, dynamic>> result = await database.query('balldetails');

    // Extract unique names from the result
    Set<String> uniqueNames = <String>{};
    for (Map<String, dynamic> row in result) {
      String name = row[
          'ballID']; // Replace 'name' with the column name containing the names in your table
      uniqueNames.add(name);
    }

    // Convert the set to a list and return
    return uniqueNames.toList();
  }

  static Future<List<String>> getUniqueBatsmanNames() async {
    Database database = await openDatabase('polygonCric.db');

    // Fetch all data from the table
    List<Map<String, dynamic>> result = await database.query('balldetails');

    // Extract unique names from the result
    Set<String> uniqueNames = <String>{};
    for (Map<String, dynamic> row in result) {
      String name = row[
          'batID']; // Replace 'name' with the column name containing the names in your table
      uniqueNames.add(name);
    }

    // Convert the set to a list and return
    return uniqueNames.toList();
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