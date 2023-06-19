import 'package:flutter/material.dart';
import 'package:polygon_cricket/bowler_select_screen/view/bowler_select.dart';

class Global {
  static double over = 0;
  static double nextOver = 1;
  static int totalRun = 0;
  static int totalWic = 0;
  static double totalOvers = 0;
  static addABall() {
    over += .1;
    String tempOverHolder = over.toStringAsFixed(1);
    over = double.parse(tempOverHolder);
    if (tempOverHolder[2] == '6') over += 0.4;
  }

  static check(BuildContext context) {
    if (over == nextOver) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('Over Completed!'),
                content: BowlerSelectingScreen(),
              ));
      nextOver += 1;
    }
  }

  static List<String> battingTeamList = [
    'Nuhin',
    'Arafat',
    'Irfana',
    'Shafiq',
    'Prohollad',
    'Tanvir',
    'Mahee',
    'Sakib',
  ];
  static List<String> ballingTeamList = [
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
  static List<Map<String, dynamic>> ballingTeam = [];
  static createBowlingTeam() {
    double maxOvers = totalOvers / 4;
    int maxOverToInt = maxOvers.round();
    for (int i = 0; i < ballingTeamList.length; i++) {
      ballingTeam.add({'name': ballingTeamList[i], 'overs': maxOverToInt});
      print(maxOverToInt);
    }
  }

  static String returnOvers(int i) {
    return '${ballingTeam[i - 1]['overs']}';
  }

  static bowlerSelected(int i) {
    ballingTeam[i]['overs'] -= 1;
  }
}
