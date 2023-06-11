import 'package:flutter/material.dart';
import 'package:polygon_cricket/global.dart';
import 'package:polygon_cricket/toss_screen/view/toss_screen.dart';

class ScoreCard extends StatefulWidget {
  static const String id = 'scoreCard';
  const ScoreCard({super.key});

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Batsman= ${Global.battingTeamList[Global.currentBatsman]}',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'Bowler= ${Global.ballingTeamList[Global.currentBowler]}',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pushNamed(context, TossScreen.id);
              });
            },
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff041421)),
            child: const Text(
              'Restart',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      )),
    );
  }
}
