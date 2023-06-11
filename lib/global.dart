import 'package:flutter/material.dart';

class Global {
  static double over = 0;

  static double totalOvers = 0;
  static addABall() {
    over += .1;
    String tempOverHolder = over.toStringAsFixed(1);
    over = double.parse(tempOverHolder);
    if (tempOverHolder[2] == '6') over += 0.4;
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
  static int currentBatsman = 0;
  static int currentBowler = 0;
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
}
