import 'package:flutter/material.dart';

import '../../global.dart';
import '../../reusable_widgets/run_button.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 122,
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
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: RunButton(
                onTap: () {
                  setState(() {
                    Global.wic = true;
                    Global.addABall(context);
                    Global.totalRun += -5;
                    Global.battingTeam[Global.currentBatsman]['status'] = 'out';
                    Global.bowlingTeam[Global.currentBowler]['wic'] += 1;

                    Global.currentBatsman = -1;
                    Global.check(context);
                  });
                },
                text: '-5'),
          ),
          Positioned(
            bottom: 370,
            left: MediaQuery.of(context).size.width / 2.45,
            child: RunButton(
              onTap: () {
                setState(() {
                  Global.addABall(context);
                  Global.totalRun += 4;
                  Global.battingTeam[Global.currentBatsman]['runs'] += 4;
                  Global.bowlingTeam[Global.currentBowler]['runs'] += 4;
                  Global.check(context);
                });
              },
              text: '4',
            ),
          ),
          Positioned(
            bottom: 370,
            left: MediaQuery.of(context).size.width / 17,
            child: RunButton(
              onTap: () {
                setState(() {
                  Global.addABall(context);
                  Global.totalRun += 4;
                  Global.battingTeam[Global.currentBatsman]['runs'] += 4;
                  Global.bowlingTeam[Global.currentBowler]['runs'] += 4;
                  Global.check(context);
                });
              },
              text: '4',
            ),
          ),
          Positioned(
            bottom: 370,
            right: MediaQuery.of(context).size.width / 17,
            child: RunButton(
              onTap: () {
                setState(() {
                  Global.addABall(context);
                  Global.totalRun += 4;
                  Global.battingTeam[Global.currentBatsman]['runs'] += 4;
                  Global.bowlingTeam[Global.currentBowler]['runs'] += 4;
                  Global.check(context);
                });
              },
              text: '4',
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.5,
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
            top: MediaQuery.of(context).size.height / 1.38,
            left: MediaQuery.of(context).size.width / 1.5,
            child: RunButton(
              onTap: () {
                setState(() {
                  Global.totalRun += 1;
                  Global.bowlingTeam[Global.currentBowler]['runs'] += 1;
                  Global.extra += 1;
                  Global.check(context);
                });
              },
              text: 'Wide',
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.6,
            left: MediaQuery.of(context).size.width / 2.5,
            child: RunButton(
              onTap: () {
                setState(() {
                  Global.wic = true;
                  Global.addABall(context);
                  Global.battingTeam[Global.currentBatsman]['status'] = 'out';
                  Global.bowlingTeam[Global.currentBowler]['wic'] += 1;
                  Global.currentBatsman = -1;
                  Global.check(context);
                });
              },
              text: 'OUT',
              color: Colors.red,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.95,
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
            top: MediaQuery.of(context).size.height / 1.9,
            left: MediaQuery.of(context).size.width / 17,
            child: RunButton(
              onTap: () {
                setState(() {
                  Global.addABall(context);
                  Global.totalRun += 1;
                  Global.battingTeam[Global.currentBatsman]['runs'] += 1;
                  Global.bowlingTeam[Global.currentBowler]['runs'] += 1;
                  Global.check(context);
                });
              },
              text: '1',
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.7,
            left: MediaQuery.of(context).size.width / 17,
            child: RunButton(
              onTap: () {
                setState(() {
                  Global.addABall(context);
                  Global.totalRun += 2;
                  Global.battingTeam[Global.currentBatsman]['runs'] += 2;
                  Global.bowlingTeam[Global.currentBowler]['runs'] += 2;
                  Global.check(context);
                });
              },
              text: '2',
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.9,
            right: MediaQuery.of(context).size.width / 17,
            child: RunButton(
              onTap: () {
                setState(() {
                  Global.addABall(context);

                  Global.totalRun += 1;
                  Global.battingTeam[Global.currentBatsman]['runs'] += 1;
                  Global.bowlingTeam[Global.currentBowler]['runs'] += 1;
                  Global.check(context);
                });
              },
              text: '1',
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.7,
            right: MediaQuery.of(context).size.width / 17,
            child: RunButton(
              onTap: () {
                setState(() {
                  Global.addABall(context);
                  Global.totalRun += 2;
                  Global.battingTeam[Global.currentBatsman]['runs'] += 2;
                  Global.bowlingTeam[Global.currentBowler]['runs'] += 2;
                  Global.check(context);
                });
              },
              text: '2',
            ),
          ),
        ],
      ),
    );
  }
}
