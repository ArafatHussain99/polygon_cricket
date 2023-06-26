import 'package:flutter/material.dart';
import 'package:polygon_cricket/global.dart';
import 'package:polygon_cricket/score_wheel/view/total_score_wheel_screen.dart';

import '../../constants/utils.dart';

class BowlerSelectingScreen extends StatefulWidget {
  static const String id = 'bowlerselectingScreen';
  const BowlerSelectingScreen({super.key});

  @override
  State<BowlerSelectingScreen> createState() => _BowlerSelectingScreenState();
}

class _BowlerSelectingScreenState extends State<BowlerSelectingScreen> {
  int selectedBaller = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Select Bowler',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: Global.bowlingTeam.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedBaller = index;
                          });
                        },
                        child: index == 0
                            ? const ListTile(
                                title: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    textBaseline: TextBaseline.alphabetic,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                trailing: Text(
                                  'Overs left',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    textBaseline: TextBaseline.alphabetic,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            : Global.bowlingTeam[index - 1]['status'] ==
                                    'not completed'
                                ? ListTile(
                                    selectedColor: Colors.amber,
                                    selected: false,
                                    tileColor: selectedBaller == index
                                        ? const Color(0xff86B9B0)
                                        : Colors.transparent,
                                    title: Text(
                                        Global.bowlingTeam[index - 1]['name']),
                                    trailing:
                                        Text(Global.returnOvers(index - 1)),
                                  )
                                : Container(),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    Global.currentBowler = selectedBaller - 1;
                    if (Global.currentBowler == -1) {
                      showSnackBar(context, 'Please select a bowler');
                    } else if (Global.lastBowler == Global.currentBowler) {
                      showSnackBar(context,
                          'Please select another bowler, since ${Global.bowlingTeam[Global.lastBowler]['name']} bowled last over.');
                    } else {
                      Global.lastBowler = Global.currentBowler;
                      Global.bowlerSelected(Global.currentBowler);
                      Navigator.pushNamed(context, ScoreWheel.id);
                    }
                  });
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xff041421)),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
