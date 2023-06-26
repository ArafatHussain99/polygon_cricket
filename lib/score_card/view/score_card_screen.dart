import 'package:flutter/material.dart';
import 'package:polygon_cricket/global.dart';

import '../controller/database_controller.dart';

class ScoreCardScreen extends StatefulWidget {
  static const String id = 'ScoreCard';
  const ScoreCardScreen({super.key});

  @override
  State<ScoreCardScreen> createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  List<Map<String, dynamic>> _outList = [];
  String teamSelected =
      'TeamA'; //change the TeamA and TeamB button color and decoration
  @override
  Widget build(BuildContext context) {
    var key1 = GlobalKey();
    var key2 = GlobalKey();

    Iterable<Map<String, dynamic>> batted =
        Global.battingTeam.where((player) => player['status'] != 'not out');

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
                    opacity: 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Global.toss == 0
                            ? const Text(
                                'Team A',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              )
                            : const Text(
                                'Team B',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                        Text(
                          '${Global.totalRun}/${Global.totalWic}',
                          style: const TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: Global.toss == 0 ? 'Team B' : 'Team A',
                            style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: ' ·',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900))
                            ]),
                      ),
                      Row(
                        children: const [
                          Text(
                            '(25/50 ov. T:257) ',
                            style: TextStyle(fontSize: 19),
                          ),
                          Text(
                            '100/1',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text('Team B needs 157 from 25.0 overs.'),
                  const Text('CRR: 4.00 · RRR: ${157 / 25}'),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            teamSelected = 'TeamA';
                          });
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
                        onTap: () {
                          setState(() {
                            teamSelected = 'TeamB';
                            // Scrollable.ensureVisible(
                            //   key2.currentContext!,
                            //   duration: const Duration(milliseconds: 500),
                            // );
                          });
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                          Text('Status: ${batted.elementAt(index)['status']}'),
                        ],
                      ),
                      SizedBox(
                        width: 35,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${batted.elementAt(index)['runs']}',
                              style: const TextStyle(
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
                          children: [
                            Text(
                              '${batted.elementAt(index)['ball']}',
                              style: const TextStyle(
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
                              '0',
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
                              '0',
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
                          children: [
                            batted.elementAt(index)['ball'] == 0
                                ? const Text(
                                    '0.00',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45),
                                  )
                                : Text(
                                    '${(batted.elementAt(index)['runs'] / batted.elementAt(index)['ball']) * 100}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black45),
                                  ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
