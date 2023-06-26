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
  //instance of my database class
  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    var key1 = GlobalKey();
    var key2 = GlobalKey();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
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
                  ElevatedButton(
                      onPressed: () async {
                        Scrollable.ensureVisible(
                          key1.currentContext!,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      child: const Text('Team A')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Scrollable.ensureVisible(
                          key2.currentContext!,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      child: const Text('Team B')),
                ],
              ),
              Container(
                height: 200,
                color: Colors.blue,
              ),
              Container(
                key: key1,
                height: 200,
                color: Colors.purple,
              ),
              Container(
                height: 400,
                color: Colors.green,
              ),
              Container(
                key: key2,
                height: 400,
                color: Colors.red,
              ),
              Container(
                height: 400,
                color: Colors.yellow,
              ),
              Container(
                height: 400,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
