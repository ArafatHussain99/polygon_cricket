import 'package:flutter/material.dart';
import 'package:polygon_cricket/batsman_select_screen/view/batsman_select.dart';
import 'package:polygon_cricket/global.dart';
import 'package:polygon_cricket/score_card/view/scorecard.dart';

class TossScreen extends StatefulWidget {
  static const String id = 'tossScreen';
  const TossScreen({super.key});

  @override
  State<TossScreen> createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen> {
  String tossWinner = 'Team A';
  String winnerSelected = 'none';
  String selectedMatchType = 'Test';
  List<String> matchTypes = <String>['Test', 'Limited Overs'];
  final overController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Text(
                    'Toss',
                    style: TextStyle(
                        fontFamily: 'Vivaldi',
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffD0D6D6)),
                  ),
                  Positioned(
                    bottom: 33,
                    right: -30,
                    child: Text(
                      tossWinner,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          winnerSelected = 'batting';
                        });
                      },
                      child: Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                            color: winnerSelected != 'batting'
                                ? const Color(0xffD0D6D6)
                                : const Color(0xff86B9B0),
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.asset(
                          'assets/images/bat.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const Text(
                      'or',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          winnerSelected = 'balling';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: winnerSelected != 'balling'
                                ? const Color(0xffD0D6D6)
                                : const Color(0xff86B9B0),
                            borderRadius: BorderRadius.circular(15)),
                        height: 200,
                        width: 150,
                        child: Image.asset(
                          'assets/images/ball.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Text(
                      'Overs: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: 220,
                        child: TextField(
                          onChanged: (x) {
                            Global.totalOvers = double.parse(x);
                          },
                          controller: overController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: 'Input the number of Overs',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Text(
                      'Match Tye: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      child: DropdownButton<String>(
                        value: selectedMatchType,
                        onChanged: (value) {
                          setState(() {
                            selectedMatchType = value!;
                          });
                        },
                        items: matchTypes.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ScoreCard.id);
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
