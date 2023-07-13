import 'package:flutter/material.dart';
import 'package:polygon_cricket/dummy_pagge/dummy_page.dart';
import 'package:polygon_cricket/global.dart';
import 'package:polygon_cricket/toss_screen/view/toss_screen.dart';

import '../controller/database_controller.dart';

class ScoreCardScreen extends StatefulWidget {
  static const String id = 'ScoreCard';
  const ScoreCardScreen({super.key});

  @override
  State<ScoreCardScreen> createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  // List<Map<String, dynamic>> _outList = [];
  List<Map<String, dynamic>> totalData = [];
  String teamSelected =
      'TeamA'; //change the TeamA and TeamB button color and decoration
  int overs = 0;
  Future<void> getOvers(int inns) async {
    await DatabaseHelper.getTotalOvers(1).then((value) {
      setState(() {
        overs = value;
      });
    });
  }

  // List<String> bowled = [];
  // Future<void> getBowlerList() async {
  //   bowled = await DatabaseHelper.getUniqueBowlerNames();
  //   print(bowled);
  // }

  @override
  void initState() {
    //getBowlerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var key1 = GlobalKey();
    // var key2 = GlobalKey();
    if (overs == 0) {
      getOvers(1);
    }
    print(overs);
    Iterable<Map<String, dynamic>> batted = Global.battingTeam
        .where((player) => player['status'] != 'not out')
        .toList()
      ..sort((a, b) => a['batAt'].compareTo(b['batAt']));

    Iterable<Map<String, dynamic>> didNotBat =
        Global.battingTeam.where((player) => player['status'] == 'not out');
    Iterable<Map<String, dynamic>> bowled =
        Global.bowlingTeam.where((player) => player['overs'] != 0);
    List<Widget> didNotBatList = [];
    List<Widget> foWList = [];

    for (int i = 0; i < didNotBat.length; i++) {
      if (i == didNotBat.length - 1) {
        didNotBatList.add(Text('${didNotBat.elementAt(i)['name']}'));
      } else {
        didNotBatList.add(Text('${didNotBat.elementAt(i)['name']}, '));
      }
    }
    //1-256 (Rahmanullah Gurbaz, 36.1 ov),
    // Global.foW.add({
    //       'batPos': Global.battingPos,
    //       'run': Global.totalRun,
    //       'name': Global.bowlingTeam[Global.currentBatsman]['name'],
    //       'over': Global.currentOver,
    // });
    for (int i = 0; i < Global.foW.length; i++) {
      if (i == didNotBat.length - 1) {
        foWList.add(Text(
            '${Global.foW.elementAt(i)['batPos']}-${Global.foW.elementAt(i)['run']} (${Global.foW.elementAt(i)['name']}, ${Global.foW.elementAt(i)['over']} ov)'));
      } else {
        foWList.add(Text(
            '${Global.foW.elementAt(i)['batPos']}-${Global.foW.elementAt(i)['run']} (${Global.foW.elementAt(i)['name']}, ${Global.foW.elementAt(i)['over']} ov), '));
      }
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Live',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Opacity(
                      opacity: Global.currentInns == 1 ? 1 : 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: Global.toss == 0 ? 'Team A' : 'Team B',
                                style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  Global.currentInns == 1
                                      ? const TextSpan(
                                          text: ' ·',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900))
                                      : const TextSpan(
                                          text: '',
                                        )
                                ]),
                          ),
                          Row(
                            children: [
                              FutureBuilder<int>(
                                future: DatabaseHelper.getTotalTeamRun(1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    );
                                  }
                                },
                              ),
                              const Text(
                                '/',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              FutureBuilder<int>(
                                future: DatabaseHelper.getTotalTeamWic(1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Opacity(
                      opacity: Global.currentInns == 1 ? 0.6 : 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: Global.toss == 0 ? 'Team B' : 'Team A',
                                style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  Global.currentInns != 1
                                      ? const TextSpan(
                                          text: ' ·',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900))
                                      : const TextSpan(
                                          text: '',
                                        )
                                ]),
                          ),
                          Global.currentInns == 1
                              ? Container()
                              : Row(
                                  children: const [
                                    Text(
                                      '(25/50 ov. T:257) ',
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    Text(
                                      '100/1',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Global.currentInns == 1
                        ? Container()
                        : const Text('Team B needs 157 from 25.0 overs.'),
                    const Text('CRR: 4.00 · RRR: ${157 / 25}'),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(Global.battingTeam);
                            // setState(() {
                            //   teamSelected = 'TeamA';
                            // });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: teamSelected == 'TeamA'
                                  ? Colors.white
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30),
                              border: teamSelected == 'TeamA'
                                  ? Border.all(color: Colors.blue, width: 1.5)
                                  : null,
                            ),
                            child: Text(
                              'Team A',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: teamSelected == 'TeamA'
                                      ? Colors.blue
                                      : Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            totalData = await Global.getInfo();
                            setState(() {
                              teamSelected = 'TeamB';
                              // Scrollable.ensureVisible(
                              //   key2.currentContext!,
                              //   duration: const Duration(milliseconds: 500),
                              // );
                            });
                            Navigator.pushNamed(context, DummyPage.id);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: teamSelected == 'TeamA'
                                  ? Colors.grey.shade300
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: teamSelected == 'TeamA'
                                  ? null
                                  : Border.all(color: Colors.blue, width: 1.5),
                            ),
                            child: Text(
                              'Team B',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: teamSelected == 'TeamA'
                                      ? Colors.black
                                      : Colors.blue),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, TossScreen.id, (route) => false);
                              DatabaseHelper.deleteDatabaseFile();
                              teamSelected = 'clear';

                              // for (var data in totalData) {
                              // }
                              // Scrollable.ensureVisible(
                              //   key2.currentContext!,
                              //   duration: const Duration(milliseconds: 500),
                              // );
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: teamSelected == 'Clear'
                                  ? Colors.grey.shade300
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: teamSelected == 'Clear'
                                  ? null
                                  : Border.all(color: Colors.red, width: 1.5),
                            ),
                            child: Text(
                              'clear',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: teamSelected == 'Clear'
                                      ? Colors.black
                                      : Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                color: Colors.blue.shade200,
                child: RichText(
                  text: TextSpan(
                    text: 'Team A',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                          text: '  (${Global.totalOvers} ovs maximum)',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                ),
              ),
              //1st inns batting
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                color: Colors.grey.shade300,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 10,
                      child: const Text(
                        'Batting',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            'R',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            'B',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            '4s',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            '6s',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width / 2) -
                          10 -
                          10 -
                          120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            'SR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: List.generate(batted.length, (index) {
                    return Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              child: Text(
                                '${batted.elementAt(index)['name']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                'Status: ${batted.elementAt(index)['status']}'),
                          ],
                        ),
                        SizedBox(
                          width: 35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FutureBuilder<int>(
                                future: DatabaseHelper.batsmansTotalRunPerInns(
                                    batted.elementAt(index)['name'], 1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FutureBuilder<int>(
                                future:
                                    DatabaseHelper.batsmansBallsFacedPerInns(
                                        batted.elementAt(index)['name'], 1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FutureBuilder<int>(
                                future: DatabaseHelper.getfoursScored(
                                    batted.elementAt(index)['name'], 1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FutureBuilder<int>(
                                future: DatabaseHelper.getSixessScored(
                                    batted.elementAt(index)['name'], 1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              (MediaQuery.of(context).size.width / 2) -
                              10 -
                              10 -
                              120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FutureBuilder<String>(
                                future:
                                    DatabaseHelper.batsmansStrikeRatePerInns(
                                        batted.elementAt(index)['name'], 1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                color: Colors.grey.shade300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        '${Global.currentOver} Ov (RR: ${((Global.totalRun / overs) * 6).toStringAsFixed(1)})',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        '${Global.totalRun}/${Global.totalWic}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ]),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(children: [
                    const Text(
                      'Yet to bat: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: didNotBatList,
                    )
                  ]),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(children: [
                    const Text(
                      'FoW: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: foWList,
                    )
                  ]),
                ),
              ),
              //1st inns bowling
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.infinity,
                color: Colors.grey.shade300,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Text(
                        'Bowling',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'O',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'R',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 27,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'W',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'Econ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            '0s',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'NB',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'WD',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: List.generate(bowled.length, (index) {
                    return Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 20,
                              child: Text(
                                '${bowled.elementAt(index)['name']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                (bowled.elementAt(index)['overs'])
                                    .toStringAsFixed(1),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${bowled.elementAt(index)['runs']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 27,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${bowled.elementAt(index)['wic']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FutureBuilder<int>(
                                future: DatabaseHelper.bowlersTotalBallsBowled(
                                    bowled.elementAt(index)['name'], 1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${((bowled.elementAt(index)['runs'] / snapshot.data) * 6).toStringAsFixed(1)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FutureBuilder<int>(
                                future: DatabaseHelper.bowlersTotalDotsBowled(
                                    bowled.elementAt(index)['name'], 1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FutureBuilder<int>(
                                future: DatabaseHelper.bowlersTotalNBBowled(
                                    bowled.elementAt(index)['name'], 1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FutureBuilder<int>(
                                future: DatabaseHelper.bowlersTotalWDBowled(
                                    bowled.elementAt(index)['name'], 1),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While the Future is not yet complete, display a loading indicator
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If an error occurred, display an error message
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      '${snapshot.data}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
