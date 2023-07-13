import 'package:flutter/material.dart';
import 'package:polygon_cricket/global.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // static Future<void> createDatabase(sql.Database database) async {
  //   print('creating database');
  //   await database.execute(
  //       '''CREATE TABLE balldetails (ballNo INTEGER PRIMARY KEY AUTOINCREMENT, batID TEXT, ballID TEXT, action TEXT, inns INTEGER)''');
  //   print('done creating database');
  // }
  static late Database database;
  late sql.Database db;
  static Future<sql.Database> open() async {
    return sql.openDatabase('polygonCric.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await database.execute(
          '''CREATE TABLE IF NOT EXISTS balldetails (ballNo INTEGER PRIMARY KEY AUTOINCREMENT, batID TEXT, ballID TEXT, action TEXT, inns INTEGER)''');
      await database.execute(
          '''CREATE TABLE IF NOT EXISTS infoTable (key TEXT, value TEXT)''');
    });
  }

  static Future<void> createInfoTable() async {
    database = await openDatabase('polygonCric.db');
    await database.execute(
        '''CREATE TABLE IF NOT EXISTS balldetails (ballNo INTEGER PRIMARY KEY AUTOINCREMENT, batID TEXT, ballID TEXT, action TEXT, inns INTEGER)''');
  }

  static Future<void> createBallDetailsTable() async {
    database = await openDatabase('polygonCric.db');
    await database.execute(
        '''CREATE TABLE IF NOT EXISTS infoTable (key TEXT, value TEXT)''');
  }

  static Future<bool> doesTableExist(String tableName) async {
    database = await openDatabase('polygonCric.db');
    List<Map<String, dynamic>> result = await database.query(
      'sqlite_master',
      where: 'type = ? AND name = ?',
      whereArgs: ['table', tableName],
    );
    print(result);

    return result.isNotEmpty;
  }

  static Future<bool> isDataAvailable() async {
    database = await openDatabase('polygonCric.db');
    List<Map<String, dynamic>> result = [];
    if (await doesTableExist('infoTable')) {
      result = await database.query('infoTable');
    }
    if (result == []) {
      return false;
    } else {
      return result.isNotEmpty;
    }
  }

  static Future<bool> dataBaseExists() async {
    // Get the directory where the database file is located
    // Directory directory = await getApplicationDocumentsDirectory();
    // String path = directory.path + '/polygonCric.db';
    String databasePath = await getDatabasesPath();
    String databaseName = 'polygonCric.db';
    String path = '$databasePath/$databaseName';
    // Check if the database file exists
    bool exists = await databaseExists(path);

    if (exists) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateInfo(BuildContext context) async {
    database = await openDatabase('polygonCric.db');
    List<Map<String, dynamic>> dataList = await database.query('infoTable');
    String? findValueByKey(String key) {
      String value = '';
      for (var item in dataList) {
        if (item['key'] == key) {
          value = item['value'];
          break;
        }
      }
      return value;
    }

    Global.tossWinnerSelected =
        int.parse(findValueByKey('tossWinnerSelected')!);
    Global.totalInns = int.parse(findValueByKey('totalInns')!);
    Global.totalOvers = double.parse(findValueByKey('totalOvers')!);
    Global.runLimit = int.parse(findValueByKey('runLimit')!);
    Global.matchType = findValueByKey('matchType')!;
    Global.updating = true;
    List<Map<String, dynamic>> ballList = await database.query('balldetails');
    if (!Global.teamCreatedStatus) {
      Global.teamCreatedStatus = true;
      if ((Global.toss == 0 && Global.tossWinnerSelected == 0) ||
          (Global.toss == 1 && Global.tossWinnerSelected == 1)) {
        Global.createBowlingTeam(Global.teamB);
        Global.createBattingTeam(Global.teamA);
      } else {
        Global.createBowlingTeam(Global.teamA);
        Global.createBattingTeam(Global.teamB);
      }
    }

    Global.updating = true;
    for (var ball in ballList) {
      int position = Global.battingTeam.indexWhere((map) {
        return map['name'] == ball['batID'];
      });
      int position2 = Global.bowlingTeam.indexWhere((map) {
        return map['name'] == ball['ballID'];
      });
      Global.currentBatsman = position;
      print(ball);
      Global.battingTeam[Global.currentBatsman]['status'] = 'batting';
      Global.currentBowler = position2;
      Global.battingTeam[Global.currentBatsman]['batAt'] = Global.battingPos;
      if (ball['action'] == '0' ||
          ball['action'] == '1' ||
          ball['action'] == '2' ||
          ball['action'] == '4' ||
          ball['action'] == '6' ||
          ball['action'] == '-5') {
        Global.battingTeam[Global.currentBatsman]['runs'] +=
            int.parse(ball['action']);
        // Global.bowlingTeam[Global.currentBowler]['overs'] += 0.1;
        // String tempOverHolder = Global.bowlingTeam[Global.currentBowler]
        //         ['overs']
        //     .toStringAsFixed(1);
        // Global.bowlingTeam[Global.currentBowler]['overs'] =
        //     double.parse(tempOverHolder);
        // if (tempOverHolder[2] == '6' && tempOverHolder.length == 3) {
        //   Global.bowlingTeam[Global.currentBowler]['overs'] += 0.4;
        // }
        // if (tempOverHolder[tempOverHolder.length - 1] == '6' &&
        //     tempOverHolder.length == 4) {
        //   Global.bowlingTeam[Global.currentBowler]['overs'] += 0.4;
        // }
        Global.addABall();
        Global.totalRun += int.parse(ball['action']);
        if (ball['action'] != '-5') {
          Global.bowlingTeam[Global.currentBowler]['runs'] +=
              int.parse(ball['action']);
        }
      }
      if (Global.battingTeam[Global.currentBatsman]['runs'] >=
          Global.battingTeam[Global.currentBatsman]['limit']) {
        Global.battingTeam[Global.currentBatsman]['status'] = 'limit exceeded';
        Global.battingTeam[Global.currentBatsman]['limit'] += Global.runLimit;
        Global.currentBatsman = -1;
      }
      if (ball['action'] == 'out' || ball['action'] == '-5') {
        if (ball['action'] != '-5') {
          // String tempOverHolder = Global.bowlingTeam[Global.currentBowler]
          //         ['overs']
          //     .toStringAsFixed(1);
          // Global.bowlingTeam[Global.currentBowler]['overs'] =
          //     double.parse(tempOverHolder);
          // if (tempOverHolder[2] == '9' && tempOverHolder.length == 3) {
          //   Global.bowlingTeam[Global.currentBowler]['overs'] -= 0.4;
          // }
          // if (tempOverHolder[tempOverHolder.length - 1] == '9' &&
          //     tempOverHolder.length == 4) {
          //   Global.bowlingTeam[Global.currentBowler]['overs'] -= 0.4;
          // }
          Global.addABall();
        }
        Global.totalWic += 1;
        Global.bowlingTeam[Global.currentBowler]['wic'] += 1;
        Global.battingTeam[Global.currentBatsman]['status'] = 'out';
        Global.battingPos += 1;
        Global.foW.add({
          'batPos': Global.battingPos,
          'run': Global.totalRun,
          'name': Global.battingTeam[Global.currentBatsman]['name'],
          'over': Global.currentOver,
        });
        Global.currentBatsman = -1;
      }
      if (ball['action'] == 'WD') {
        Global.extra += 1;
        Global.bowlingTeam[Global.currentBowler]['runs'] += 1;
      }
      // ignore: use_build_context_synchronously
      Global.check(context);
    }
    Global.updating = false;
    // ignore: use_build_context_synchronously
    Global.check(context);
    // if (Global.tossWinnerSelected != -1 &&
    //     Global.totalInns != -1 &&
    //     Global.totalOvers != 0.0 &&
    //     Global.runLimit != 0 &&
    //     Global.matchType != '') {
    //   return true;
    // } else {
    //   return false;
    // }
    return true;
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

  static Future<int> insertInfo(String key, String value) async {
    final db = await DatabaseHelper.open();

    final data = {
      'key': key,
      'value': value,
    };
    final id = await db.insert('infoTable', data);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    database = await DatabaseHelper.open();

    return database.query('balldetails', orderBy: "ballNo");
  }

  static Future<List<Map<String, dynamic>>> getItem(String action) async {
    database = await DatabaseHelper.open();
    return database.query('balldetails',
        where: "action = ?", whereArgs: [action], limit: 2);
  }

  static Future<List<Map<String, dynamic>>> getInfo() async {
    database = await DatabaseHelper.open();
    return database
        .query('infoTable', where: "key = ?", whereArgs: ['totalOvers']);
  }

  static Future<int> updateItem(
      int ballNo, String action, String batID, String ballID, int inns) async {
    database = await DatabaseHelper.open();
    final data = {
      'action': action,
      'batID': batID,
      'ballID': ballID,
      'inns': inns
    };
    final result = await database
        .update('balldetails', data, where: "id = ?", whereArgs: [ballNo]);
    return result;
  }

  static Future<void> deleteItem(String action) async {
    database = await DatabaseHelper.open();
    try {
      await database
          .delete('balldetails', where: 'action = ?', whereArgs: [action]);
    } catch (err) {
      debugPrint('Something wrong: $err');
    }
  }

  static Future<void> deleteTable() async {
    database = await DatabaseHelper.open();
    try {
      await database.execute('DROP TABLE IF EXISTS balldetails');
    } catch (err) {
      debugPrint('Something wrong: $err');
    }
  }

  static Future<void> deleteDatabaseFile() async {
    database = await DatabaseHelper.open();
    // // Get the directory where the database file is located
    // // Directory directory = await getApplicationDocumentsDirectory();
    // // String path = directory.path + '/polygonCric.db';
    // String databasePath = await getDatabasesPath();
    // String databaseName = 'polygonCric.db';
    // String path = '$databasePath/$databaseName';
    // // Check if the database file exists
    // bool exists = await databaseExists(path);

    // print('deleting database');
    // if (exists) {
    //   // Close any open connections to the database
    //   await database.close();

    //   // Delete the database file
    //   await deleteDatabase(path);
    // }
    await database.delete('infoTable');
    await database.delete('ballDetails');
    await database.close();
  }

  static Future<int> version() async {
    database = await DatabaseHelper.open();
    return database.getVersion();
  }

  static Future<int> getTotalOvers(int inns) async {
    database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where:
          'inns = ? AND (action = ? OR action = ? OR action = ? OR action = ? OR action = ?)',
      whereArgs: [inns, '1', '2', '4', 'out', '6'],
    );

    return result.length;
  }

  static Future<int> getfoursScored(String batID, int inns) async {
    database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'batID = ? AND action = ? AND inns = ?',
      whereArgs: [batID, '4', inns],
    );

    return result.length;
  }

  static Future<int> getSixessScored(String batID, int inns) async {
    database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'batID = ? AND action = ? AND inns = ?',
      whereArgs: [batID, '6', inns],
    );

    return result.length;
  }

  static Future<int> batsmansTotalRunPerInns(String batID, int inns) async {
    database = await openDatabase('polygonCric.db');

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
    database = await openDatabase('polygonCric.db');

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

  static Future<int> bowlersTotalBallsBowled(String ballID, int inns) async {
    database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'ballID = ? AND inns = ?',
      whereArgs: [ballID, inns],
    );
    int totalBalls = 0;
    for (Map<String, dynamic> action in result) {
      if (action['action'] == 'NB') {
        continue;
      }
      if (action['action'] == 'WD') {
        continue;
      }
      totalBalls += 1;
    }
    return totalBalls;
  }

  static Future<int> totalBallsBowled(int inns) async {
    database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'inns = ?',
      whereArgs: [inns],
    );
    int totalBalls = 0;
    for (Map<String, dynamic> action in result) {
      if (action['action'] == 'NB') {
        continue;
      }
      if (action['action'] == 'WD') {
        continue;
      }
      totalBalls += 1;
    }
    return totalBalls;
  }

  static Future<int> bowlersTotalDotsBowled(String ballID, int inns) async {
    database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'ballID = ? AND inns = ? AND action = ?',
      whereArgs: [ballID, inns, '0'],
    );
    return result.length;
  }

  static Future<int> bowlersTotalNBBowled(String ballID, int inns) async {
    database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'ballID = ? AND inns = ? AND action = ?',
      whereArgs: [ballID, inns, 'NB'],
    );
    return result.length;
  }

  static Future<int> bowlersTotalWDBowled(String ballID, int inns) async {
    database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'ballID = ? AND inns = ? AND action = ?',
      whereArgs: [ballID, inns, 'WD'],
    );
    return result.length;
  }

  static Future<int> getTotalTeamRun(int inns) async {
    database = await openDatabase('polygonCric.db');

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
    database = await openDatabase('polygonCric.db');

    List<Map<String, dynamic>> result = await database.query(
      'balldetails',
      where: 'inns = ? AND action = ?',
      whereArgs: [inns, 'out'],
    );
    List<Map<String, dynamic>> result2 = await database.query(
      'balldetails',
      where: 'inns = ? AND action = ?',
      whereArgs: [inns, '-5'],
    );
    return result.length + result2.length;
  }

  static Future<List<String>> getUniqueBowlerNames() async {
    database = await openDatabase('polygonCric.db');

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
    database = await openDatabase('polygonCric.db');

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