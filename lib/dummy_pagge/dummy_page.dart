import 'package:flutter/material.dart';
import 'package:polygon_cricket/global.dart';
import 'package:polygon_cricket/score_card/controller/database_controller.dart';

class DummyPage extends StatelessWidget {
  static const String id = 'dummyy';
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your app has data!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text('Total over: ${Global.totalOvers}'),
          Text('Toss winner selected: ${Global.tossWinnerSelected}'),
          Text('Total Inns: ${Global.totalInns}'),
          Text('Match Type: ${Global.matchType}'),
          Text('Run Limit : ${Global.runLimit}'),
          Text('Current Batting : ${Global.currentBatsman}'),
          Text('Current Bowling : ${Global.currentBowler}'),
          Text('Overs : ${Global.currentOver}'),
          TextButton(
              onPressed: () {
                DatabaseHelper.updateInfo(context);
              },
              child: const Text('print info'))
        ],
      )),
    );
  }
}
