import 'package:flutter/material.dart';
import 'package:polygon_cricket/global.dart';
import 'package:polygon_cricket/reusable_widgets/run_button.dart';

class ScoreCard extends StatefulWidget {
  static const String id = 'scoreCard';
  const ScoreCard({super.key});

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  @override
  void initState() {
    Global.createBowlingTeam(Global.teamA);
    Global.createBattingTeam(Global.teamB);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      Global.check(context);
    });

    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Opacity(
                    opacity: 0.7,
                    child: Image.asset(
                      'assets/images/background.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: RunButton(
                        onTap: () {
                          setState(() {
                            Global.addABall();
                            Global.check(context);
                            Global.totalRun += -5;
                            Global.battingTeam[Global.currentBatsman]
                                ['status'] = 'out';
                            Global.bowlingTeam[Global.currentBowler]['wic'] +=
                                1;
                          });
                        },
                        text: '-5'),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2.5,
                  left: MediaQuery.of(context).size.width / 2.25,
                  child: RunButton(
                    onTap: () {
                      setState(() {
                        Global.addABall();
                        Global.check(context);
                        Global.totalRun += 4;
                        Global.battingTeam[Global.currentBatsman]['runs'] += 4;
                        Global.bowlingTeam[Global.currentBowler]['runs'] += 4;
                      });
                    },
                    text: '4',
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.75,
                  left: MediaQuery.of(context).size.width / 2,
                  child: RunButton(
                    onTap: () {
                      setState(() {
                        Global.check(context);
                        Global.totalRun += 1;
                        Global.bowlingTeam[Global.currentBowler]['runs'] += 1;
                        Global.extra += 1;
                      });
                    },
                    text: 'No Ball',
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.15,
                  left: MediaQuery.of(context).size.width / 1.3,
                  child: RunButton(
                    onTap: () {
                      setState(() {
                        Global.check(context);
                        Global.totalRun += 1;
                        Global.bowlingTeam[Global.currentBowler]['runs'] += 1;
                        Global.extra += 1;
                      });
                    },
                    text: 'Wide',
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.15,
                  left: MediaQuery.of(context).size.width / 2.3,
                  child: RunButton(
                    onTap: () {
                      setState(() {
                        Global.wic = true;
                        Global.addABall();
                        Global.check(context);
                        Global.totalWic += 1;
                        Global.battingTeam[Global.currentBatsman]['status'] =
                            'out';
                        Global.bowlingTeam[Global.currentBowler]['wic'] += 1;
                      });
                    },
                    text: 'OUT',
                    color: Colors.red,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.35,
                  left: MediaQuery.of(context).size.width / 2.3,
                  child: RunButton(
                    onTap: () {
                      setState(() {
                        Global.addABall();
                        Global.check(context);
                      });
                    },
                    text: 'Dot',
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 1.25,
                  left: 20,
                  child: RunButton(
                    onTap: () {
                      setState(() {
                        Global.addABall();
                        Global.check(context);
                        Global.totalRun += 1;
                        Global.battingTeam[Global.currentBatsman]['runs'] += 1;
                        Global.bowlingTeam[Global.currentBowler]['runs'] += 1;
                      });
                    },
                    text: '1',
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2,
                  left: 20,
                  child: RunButton(
                    onTap: () {
                      setState(() {
                        Global.addABall();
                        Global.check(context);
                        Global.totalRun += 2;
                        Global.battingTeam[Global.currentBatsman]['runs'] += 2;
                        Global.bowlingTeam[Global.currentBowler]['runs'] += 2;
                      });
                    },
                    text: '2',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 112,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Score',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${Global.totalRun}/${Global.totalWic}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                'Extra: ${Global.extra}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Over',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${Global.currentOver}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 112,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Current Batsman',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Global.currentBatsman == -1
                                ? const Text('Null')
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${Global.battingTeam[Global.currentBatsman]['name']}',
                                        style: const TextStyle(
                                            color: Colors.yellow, fontSize: 25),
                                      ),
                                      Text(
                                        '${Global.battingTeam[Global.currentBatsman]['runs']}[${Global.battingTeam[Global.currentBatsman]['ball']}]',
                                        style: const TextStyle(
                                            color: Colors.yellow, fontSize: 25),
                                      ),
                                    ],
                                  ),
                            const Text(
                              'Current Bowler',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Global.currentBowler == -1
                                ? const Text('Null')
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${Global.bowlingTeam[Global.currentBowler]['name']}',
                                        style: const TextStyle(
                                            color: Colors.yellow, fontSize: 25),
                                      ),
                                      Text(
                                        '${Global.bowlingTeam[Global.currentBowler]['runs']}/${Global.bowlingTeam[Global.currentBowler]['wic']}',
                                        style: const TextStyle(
                                            color: Colors.yellow, fontSize: 25),
                                      ),
                                    ],
                                  ),
                          ]),
                    ),
                  ),
                ],
              ),
            )
            // Text(
            //     'Score: ${Global.totalRun}/${Global.totalWic}       Overs: ${Global.over}'),
          ],
        ),
      )),
    );
  }
}
