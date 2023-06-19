import 'package:flutter/material.dart';
import 'package:polygon_cricket/global.dart';
import 'package:polygon_cricket/reusable_widgets/run_button.dart';
import 'package:polygon_cricket/toss_screen/view/toss_screen.dart';

class ScoreCard extends StatefulWidget {
  static const String id = 'scoreCard';
  const ScoreCard({super.key});

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  @override
  void initState() {
    Global.createBowlingTeam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      });
                    },
                    text: '2',
                  ),
                ),
              ],
            ),
            Text(
                'Score: ${Global.totalRun}/${Global.totalWic}       Overs: ${Global.over}'),
          ],
        ),
      )),
    );
  }
}
