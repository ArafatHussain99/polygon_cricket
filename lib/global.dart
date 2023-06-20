import 'package:flutter/material.dart';
import 'package:polygon_cricket/batsman_select_screen/view/batsman_select.dart';
import 'package:polygon_cricket/bowler_select_screen/view/bowler_select.dart';

class Global {
  static double currentOver = 0;
  static double nextOver = 1;
  static int totalRun = 0;
  static int totalWic = 0;
  static double totalOvers = 0;
  static bool wic = false;
  static int extra = 0;
  static addABall() {
    currentOver += .1;
    String tempOverHolder = currentOver.toStringAsFixed(1);
    currentOver = double.parse(tempOverHolder);
    if (tempOverHolder[2] == '6') currentOver += 0.4;
    Global.battingTeam[Global.currentBatsman]['ball'] += 1;
  }

  static check(BuildContext context) {
    if (currentOver == nextOver || currentOver == 0) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: BowlerSelectingScreen(),
              ));
      if (currentOver != 0) nextOver += 1;
    }
    if (wic || currentOver == 0) {
      wic = false;
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: BatsmanSelectScreen(),
              ));
    }
  }

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
  static int currentBatsman = -1;
  static int currentBowler = -1;
  static List<Map<String, dynamic>> battingTeam = [];
  static List<Map<String, dynamic>> bowlingTeam = [];
  static createBowlingTeam(List<String> team) async {
    double maxOvers = totalOvers / 4;
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
    double maxOvers = totalOvers / 4;
    int maxOverToInt = maxOvers.round();
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
      bowlingTeam.removeAt(i);
    }
  }
}
