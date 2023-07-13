import 'package:flutter/material.dart';
import 'package:polygon_cricket/batsman_select_screen/view/batsman_select.dart';
import 'package:polygon_cricket/bowler_select_screen/view/bowler_select.dart';
import 'package:polygon_cricket/constants/utils.dart';
import 'package:polygon_cricket/score_card/controller/database_controller.dart';

class Global {
  //Dummy values
  static List<String> teamA = [
    'Nuhin',
    'Arafat',
    'Irfana',
    'Shafiq',
    'Prohollad',
    'Tanvir',
    'Mahee',
    'Sakib',
  ];
  static List<String> teamB = [
    'Asif',
    'Emu',
    'Subir',
    'Pritam',
    'Adnan',
    'Rabbi',
    'Hritu',
    'Bijoy'
  ];

  //Software handling variables

  static bool animation = false;
  static bool updating = false;

  static double currentOver = 0;
  static int currentInns = 1;
  static int extra = 0;
  static String matchType = '';
  static double nextOver = 1;

  static double maxBowlerOver = 0;
  static bool overAddedToNextOver = false;
  static int runLimit = 0;
  static bool teamCreatedStatus =
      false; //to stop creating team more than once, as it adding players again and agian.
  static int toss = 0;
  static int tossWinnerSelected = -1;
  static int totalInns = -1;
  static double totalOvers = 0;
  static int totalRun = 0;
  static int totalWic = 0;
  static bool wic = false;

  static int currentBatsman = -1;
  static int currentBowler = -1;
  static int battingPos = 0;
  static int lastBowler = -2;
  static List<Map<String, dynamic>> battingTeam = [];
  static List<Map<String, dynamic>> bowlingTeam = [];
  static List<Map<String, dynamic>> foW = [];
  static List<Map<String, dynamic>> totalPlayerInfo = [];

  static List<Map<String, dynamic>> totalMatchInfo = [];
  static bool innsInfoAdded = false;

  static addBatsmanInfo(int inns) {
    for (int i = 0; i < battingTeam.length; i++) {
      totalPlayerInfo.add({
        'name': battingTeam[i]['name'],
        'runs': battingTeam[i]['runs'],
        'ball': battingTeam[i]['ball'],
        'status': battingTeam[i]['status'],
        'limit': battingTeam[i]['limit'],
        'batAt': battingTeam[i]['batAt'],
        'inns': inns,
        'team': inns == 1 ? 'TeamA' : 'TeamB'
      });
    }
  }

  static addBowlerInfo(int inns) {
    for (int i = 0; i < bowlingTeam.length; i++) {
      totalPlayerInfo.add({
        // 'name': team[i],
        // 'overs': 0.0,
        // 'runs': 0,
        // 'wic': 0,
        // 'status': 'not completed'
        'name': bowlingTeam[i]['name'],
        'overs': bowlingTeam[i]['overs'],
        'runs': bowlingTeam[i]['runs'],
        'wic': bowlingTeam[i]['wic'],
        'status': bowlingTeam[i]['status'],
        'inns': inns,
        'team': inns == 1 ? 'TeamB' : 'TeamA'
      });
    }
  }

  static addMatchInfo(int inns) {
    totalMatchInfo.add({
      'over': currentOver,
      'inns': inns,
    });
    totalMatchInfo.add({
      'over': currentOver,
      'run': totalRun,
    });
    totalMatchInfo.add({
      'wic': totalWic,
      'run': totalWic,
    });
  }

  static addABall(/*BuildContext context*/) {
    currentOver += .1;
    Global.bowlingTeam[Global.currentBowler]['overs'] += 0.1;
    String tempOverHolder = currentOver.toStringAsFixed(1);
    currentOver = double.parse(tempOverHolder);
    if (tempOverHolder[2] == '6' && tempOverHolder.length == 3) {
      currentOver += 0.4;
    }
    if (tempOverHolder[tempOverHolder.length - 1] == '6' &&
        tempOverHolder.length == 4) {
      currentOver += 0.4;
    }
    String tempOverHolder2 =
        Global.bowlingTeam[Global.currentBowler]['overs'].toStringAsFixed(1);
    Global.bowlingTeam[Global.currentBowler]['overs'] =
        double.parse(tempOverHolder2);
    if (tempOverHolder2[2] == '6' && tempOverHolder2.length == 3) {
      Global.bowlingTeam[Global.currentBowler]['overs'] += 0.4;
    }
    if (tempOverHolder2[tempOverHolder2.length - 1] == '6' &&
        tempOverHolder2.length == 4) {
      Global.bowlingTeam[Global.currentBowler]['overs'] += 0.4;
    }
    if (wic || currentBatsman == -1) {
      wic = false;
      if (currentOver != 0) {
        totalWic += 1;
      }
      // showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (context) => const AlertDialog(
      //           content: BatsmanSelectScreen(),
      //         ));
    } else {
      Global.battingTeam[Global.currentBatsman]['ball'] += 1;
    }
  }

  static check(BuildContext context) {
    if ((currentOver == nextOver || currentBowler == -1) && !animation) {
      if (currentOver != totalOvers && !updating) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AlertDialog(
                  content: BowlerSelectingScreen(),
                ));
      }
      if (currentOver != 0) {
        currentBowler = -1;

        if (!overAddedToNextOver) {
          nextOver += 1;
          overAddedToNextOver = true;
        }
      }
    }
    String tempOverHolder = currentOver.toStringAsFixed(1);
    currentOver = double.parse(tempOverHolder);
    if (tempOverHolder[2] == '1' && tempOverHolder.length == 3) {
      overAddedToNextOver = false;
    }
    if (tempOverHolder[tempOverHolder.length - 1] == '1' &&
        tempOverHolder.length == 4) {
      overAddedToNextOver = false;
    }
    if ((wic || currentBatsman == -1) && currentOver != totalOvers) {
      if (currentOver != 0 && wic) {
        totalWic += 1;
      }
      wic = false;
      if (!updating && totalWic != battingTeam.length) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AlertDialog(
                  content: BatsmanSelectScreen(),
                ));
      }
    }
    if ((currentOver == totalOvers || totalWic == teamA.length) && !updating) {
      if (!innsInfoAdded) {
        addBatsmanInfo(currentInns);
        addBowlerInfo(currentInns);
        innsInfoAdded = true;
      }
      print(totalPlayerInfo.length);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                content: const Text('1st Inns Competed!'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Start next innings'))
                ],
              ));
    }
    if (currentBatsman != -1) {
      if (battingTeam[Global.currentBatsman]['runs'] >=
          battingTeam[Global.currentBatsman]['limit']) {
        battingTeam[Global.currentBatsman]['status'] = 'limit exceeded';
        battingTeam[Global.currentBatsman]['limit'] += runLimit;
        if (!updating) {
          showSnackBar(context,
              "${battingTeam[Global.currentBatsman]['name']}'s run exceeded total run limit");
        }
        if (currentOver != totalOvers) {
          currentBatsman = -1;
        }
      }
    }
    if (Global.battingTeam
        .where((player) => player['status'] == 'not out')
        .isEmpty) {
      runLimit += runLimit;
    }
  }

  static createBowlingTeam(List<String> team) async {
    double maxOvers = totalOvers < 4 ? 1 : totalOvers / 4;
    int maxOverToInt = maxOvers.round();
    String tempOverHolder = '$maxOverToInt.0';
    maxBowlerOver = double.parse(tempOverHolder);
    for (int i = 0; i < team.length; i++) {
      bowlingTeam.add({
        'name': team[i],
        'overs': 0.0,
        'runs': 0,
        'wic': 0,
        'status': 'not completed'
      });
    }
  }

  static createBattingTeam(List<String> team) async {
    for (int i = 0; i < team.length; i++) {
      battingTeam.add({
        'name': team[i],
        'runs': 0,
        'ball': 0,
        'status': 'not out',
        'limit': runLimit,
        'batAt': -1,
        'inns': currentInns,
      });
    }
  }

  static String returnOvers(int i) {
    return '${maxBowlerOver - bowlingTeam[i]['overs']}';
  }

  static bowlerSelected(int i) {
    if (bowlingTeam[i]['overs'] == maxBowlerOver) {
      bowlingTeam[i]['status'] = 'completed';
    }
  }

  static Future<void> insertData(String action) async {
    await DatabaseHelper.createItem(battingTeam[Global.currentBatsman]['name'],
        bowlingTeam[Global.currentBowler]['name'], action, currentInns);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    List<Map<String, dynamic>> dataList = await DatabaseHelper.getItems();
    return dataList;
  }

  static Future<List<Map<String, dynamic>>> getInfo() async {
    List<Map<String, dynamic>> dataList = await DatabaseHelper.getInfo();
    return dataList;
  }

  static Future<void> deleteData() async {
    await DatabaseHelper.deleteTable();
  }

  static Future<void> createDatabase() async {
    await DatabaseHelper.open();
  }
}
