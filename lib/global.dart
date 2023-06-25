import 'package:flutter/material.dart';
import 'package:polygon_cricket/batsman_select_screen/view/batsman_select.dart';
import 'package:polygon_cricket/bowler_select_screen/view/bowler_select.dart';
import 'package:polygon_cricket/constants/utils.dart';

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
  static double currentOver = 0;
  static int extra = 0;
  static String matchType = '';
  static double nextOver = 1;
  static bool overAddedToNextOver = false;
  static int runLimit = 0;
  static bool teamCreatedStatus =
      false; //to stop creating team more than once, as it adding players again and agian.
  static int toss = 0;
  static int tossWinnerSelected = -1;
  static double totalOvers = 0;
  static int totalRun = 0;
  static int totalWic = 0;
  static bool wic = false;

  static int currentBatsman = -1;
  static int currentBowler = -1;
  static int lastBowler = -2;
  static List<Map<String, dynamic>> battingTeam = [];
  static List<Map<String, dynamic>> bowlingTeam = [];

  static addABall(BuildContext context) {
    currentOver += .1;
    String tempOverHolder = currentOver.toStringAsFixed(1);
    currentOver = double.parse(tempOverHolder);
    if (tempOverHolder[2] == '6' && tempOverHolder.length == 3) {
      currentOver += 0.4;
    }
    if (tempOverHolder[tempOverHolder.length - 1] == '6' &&
        tempOverHolder.length == 4) {
      currentOver += 0.4;
    }
    if (wic || currentBatsman == -1) {
      wic = false;
      if (currentOver != 0) {
        totalWic += 1;
      }
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertDialog(
                content: BatsmanSelectScreen(),
              ));
    } else {
      Global.battingTeam[Global.currentBatsman]['ball'] += 1;
    }
  }

  static check(BuildContext context) {
    if ((currentOver == nextOver || currentBowler == -1) && !animation) {
      if (currentOver != totalOvers) {
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
    if (wic || currentBatsman == -1) {
      if (currentOver != 0 && wic) {
        totalWic += 1;
      }
      wic = false;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertDialog(
                content: BatsmanSelectScreen(),
              ));
    }
    if (currentOver == totalOvers) {
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
      if (battingTeam[Global.currentBatsman]['runs'] >= runLimit) {
        battingTeam[Global.currentBatsman]['status'] = 'limit exceeded';
        showSnackBar(context,
            "${battingTeam[Global.currentBatsman]['name']}'s run exceeded total run limit");
        currentBatsman = -1;
      }
    }
    if (Global.battingTeam
        .where((player) => player['status'] == 'not out')
        .isEmpty) {
      runLimit = 1000;
    }
  }

  static createBowlingTeam(List<String> team) async {
    double maxOvers = totalOvers < 4 ? 1 : totalOvers / 4;
    int maxOverToInt = maxOvers.round();
    for (int i = 0; i < team.length; i++) {
      bowlingTeam.add({
        'name': team[i],
        'overs': maxOverToInt,
        'runs': 0,
        'wic': 0,
        'status': 'not completed'
      });
    }
  }

  static createBattingTeam(List<String> team) async {
    for (int i = 0; i < team.length; i++) {
      battingTeam
          .add({'name': team[i], 'runs': 0, 'ball': 0, 'status': 'not out'});
    }
  }

  static String returnOvers(int i) {
    return '${bowlingTeam[i]['overs']}';
  }

  static bowlerSelected(int i) {
    bowlingTeam[i]['overs'] -= 1;
    if (bowlingTeam[i]['overs'] == 0) {
      bowlingTeam[i]['status'] = 'completed';
    }
  }
}
