import 'package:flutter/material.dart';
import 'package:polygon_cricket/global.dart';
import 'package:polygon_cricket/score_card/view/scorecard.dart';

class BowlerSelectingScreen extends StatefulWidget {
  static const String id = 'bowlerselectingScreen';
  const BowlerSelectingScreen({super.key});

  @override
  State<BowlerSelectingScreen> createState() => _BowlerSelectingScreenState();
}

class _BowlerSelectingScreenState extends State<BowlerSelectingScreen> {
  late List<String> bowlers = Global.ballingTeamList;
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
                    itemCount: bowlers.length + 1,
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
                            : ListTile(
                                selectedColor: Colors.amber,
                                selected: false,
                                tileColor: selectedBaller == index
                                    ? const Color(0xff86B9B0)
                                    : Colors.transparent,
                                title: Text(bowlers[index - 1]),
                                trailing: Text(Global.returnOvers(index)),
                              ),
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
                    print(Global.currentBowler);
                    Global.bowlerSelected(Global.currentBowler);

                    Navigator.pushNamed(context, ScoreCard.id);
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
