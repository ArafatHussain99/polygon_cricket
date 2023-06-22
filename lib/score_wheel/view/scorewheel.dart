import 'package:flutter/material.dart';
import 'package:polygon_cricket/global.dart';
import 'package:polygon_cricket/reusable_widgets/run_button.dart';
import 'package:polygon_cricket/score_wheel/view/out_animation.dart';

class ScoreWheel extends StatefulWidget {
  static const String id = 'ScoreWheel';
  const ScoreWheel({super.key});

  @override
  State<ScoreWheel> createState() => _ScoreWheelState();
}

class _ScoreWheelState extends State<ScoreWheel> {
  @override
  void initState() {
    if (Global.teamCreatedStatus == false) {
      Global.teamCreatedStatus = true;
      if ((Global.toss == 0 && Global.tossWinnerSelected == 0) ||
          (Global.toss == 1 && Global.tossWinnerSelected == 1)) {
        Global.createBowlingTeam(Global.teamB);
        Global.createBattingTeam(Global.teamA);
      } else {
        Global.createBowlingTeam(Global.teamA);
        Global.createBattingTeam(Global.teamB);
      }
    }
    setState(() {
      image = 'assets/images/out2.jpg';
    });
    super.initState();
  }

  String image = 'assets/images/out1.jpg';
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      print(Global.currentBatsman);
      print(Global.wic);
      Global.check(context);
    });
    null;

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 70,
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                Text(
                                  '${Global.totalRun}/${Global.totalWic}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 21),
                                ),
                                Text(
                                  'Extra: ${Global.extra}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9.5),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                Text(
                                  '${Global.currentOver}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22),
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
                        height: 70,
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8),
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
                                              color: Colors.yellow,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          '${Global.battingTeam[Global.currentBatsman]['runs']}[${Global.battingTeam[Global.currentBatsman]['ball']}]',
                                          style: const TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 13.5),
                                        ),
                                      ],
                                    ),
                              const Text(
                                'Current Bowler',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8),
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
                                              color: Colors.yellow,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          '${Global.bowlingTeam[Global.currentBowler]['runs']}/${Global.bowlingTeam[Global.currentBowler]['wic']}',
                                          style: const TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 13.5),
                                        ),
                                      ],
                                    ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              Global.animation == false
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, bottom: 10),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 160,
                            width: double.infinity,
                            child: Opacity(
                              opacity: 0.7,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/background.jpg',
                                  fit: BoxFit.fitWidth,
                                  alignment: AlignmentDirectional.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 30,
                            left: MediaQuery.of(context).size.width / 2.45,
                            child: RunButton(
                                onTap: () {
                                  setState(() {
                                    Global.wic = true;
                                    Global.addABall(context);
                                    Global.totalRun += -5;
                                    Global.battingTeam[Global.currentBatsman]
                                        ['status'] = 'out';
                                    Global.bowlingTeam[Global.currentBowler]
                                        ['wic'] += 1;
                                    Global.currentBatsman = -1;
                                    Global.check(context);
                                  });
                                },
                                text: '-5'),
                          ),
                          //center4
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 2.5,
                            left: MediaQuery.of(context).size.width / 2.45,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.addABall(context);
                                  Global.totalRun += 4;
                                  Global.battingTeam[Global.currentBatsman]
                                      ['runs'] += 4;
                                  Global.bowlingTeam[Global.currentBowler]
                                      ['runs'] += 4;
                                  Global.check(context);
                                });
                              },
                              text: '4',
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 2.15,
                            left: MediaQuery.of(context).size.width / 2.45,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.addABall(context);
                                  Global.totalRun += 6;
                                  Global.battingTeam[Global.currentBatsman]
                                      ['runs'] += 6;
                                  Global.bowlingTeam[Global.currentBowler]
                                      ['runs'] += 6;
                                  Global.check(context);
                                });
                              },
                              text: '6',
                            ),
                          ),
                          //left4
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 2.5,
                            left: MediaQuery.of(context).size.width / 17,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.addABall(context);
                                  Global.totalRun += 4;
                                  Global.battingTeam[Global.currentBatsman]
                                      ['runs'] += 4;
                                  Global.bowlingTeam[Global.currentBowler]
                                      ['runs'] += 4;
                                  Global.check(context);
                                });
                              },
                              text: '4',
                            ),
                          ),
                          //right4
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 2.5,
                            right: MediaQuery.of(context).size.width / 17,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.addABall(context);
                                  Global.totalRun += 4;
                                  Global.battingTeam[Global.currentBatsman]
                                      ['runs'] += 4;
                                  Global.bowlingTeam[Global.currentBowler]
                                      ['runs'] += 4;
                                  Global.check(context);
                                });
                              },
                              text: '4',
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 2.2,
                            left: MediaQuery.of(context).size.width / 2.5,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.check(context);
                                });
                              },
                              text: 'No Ball',
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 1.5,
                            left: MediaQuery.of(context).size.width / 1.5,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.totalRun += 1;
                                  Global.bowlingTeam[Global.currentBowler]
                                      ['runs'] += 1;
                                  Global.extra += 1;
                                  Global.check(context);
                                });
                              },
                              text: 'Wide',
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 1.5,
                            left: MediaQuery.of(context).size.width / 2.6,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.addABall(context);
                                  Global.battingTeam[Global.currentBatsman]
                                      ['status'] = 'out';
                                  Global.bowlingTeam[Global.currentBowler]
                                      ['wic'] += 1;
                                  Global.animation = true;
                                  Global.check(context);
                                });
                              },
                              text: 'OUT',
                              color: Colors.red,
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 1.7,
                            left: MediaQuery.of(context).size.width / 2.4,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.addABall(context);
                                  Global.check(context);
                                });
                              },
                              text: 'Dot',
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 1.8,
                            left: MediaQuery.of(context).size.width / 17,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.addABall(context);
                                  Global.totalRun += 1;
                                  Global.battingTeam[Global.currentBatsman]
                                      ['runs'] += 1;
                                  Global.bowlingTeam[Global.currentBowler]
                                      ['runs'] += 1;
                                  Global.check(context);
                                });
                              },
                              text: '1',
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 2.3,
                            left: MediaQuery.of(context).size.width / 17,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.addABall(context);
                                  Global.totalRun += 2;
                                  Global.battingTeam[Global.currentBatsman]
                                      ['runs'] += 2;
                                  Global.bowlingTeam[Global.currentBowler]
                                      ['runs'] += 2;
                                  Global.check(context);
                                });
                              },
                              text: '2',
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 1.8,
                            right: MediaQuery.of(context).size.width / 17,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.addABall(context);
                                  Global.totalRun += 1;
                                  Global.battingTeam[Global.currentBatsman]
                                      ['runs'] += 1;
                                  Global.bowlingTeam[Global.currentBowler]
                                      ['runs'] += 1;
                                  Global.check(context);
                                });
                              },
                              text: '1',
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 2.3,
                            right: MediaQuery.of(context).size.width / 17,
                            child: RunButton(
                              onTap: () {
                                setState(() {
                                  Global.addABall(context);
                                  Global.totalRun += 2;
                                  Global.battingTeam[Global.currentBatsman]
                                      ['runs'] += 2;
                                  Global.bowlingTeam[Global.currentBowler]
                                      ['runs'] += 2;
                                  Global.check(context);
                                });
                              },
                              text: '2',
                            ),
                          ),
                        ],
                      ),
                    )
                  : OutAnimation()
            ],
          ),
        )),
      ),
    );
  }
}
