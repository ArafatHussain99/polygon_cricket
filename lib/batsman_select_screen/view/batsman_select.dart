import 'package:flutter/material.dart';
import 'package:polygon_cricket/bowler_select_screen/view/bowler_select.dart';
import 'package:polygon_cricket/global.dart';

class BatsmanSelectScreen extends StatefulWidget {
  static const String id = 'batsmanscreen';
  const BatsmanSelectScreen({super.key});

  @override
  State<BatsmanSelectScreen> createState() => _BatsmanSelectScreenState();
}

class _BatsmanSelectScreenState extends State<BatsmanSelectScreen> {
  late List<String> batsmans = Global.battingTeamList;
  int selectedBatsman = 0;

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
                  'Select Batsman',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: batsmans.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedBatsman = index;
                          });
                        },
                        child: index == 0
                            ? const ListTile(
                                title: Text(
                                  'Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              )
                            : ListTile(
                                selectedColor: Colors.amber,
                                selected: false,
                                tileColor: selectedBatsman == index
                                    ? const Color(0xff86B9B0)
                                    : Colors.transparent,
                                title: Text(batsmans[index - 1]),
                              ),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Global.currentBatsman = selectedBatsman - 1;
                        Navigator.pushNamed(context, BowlerSelectingScreen.id);
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
            ],
          ),
        ),
      ),
    );
  }
}
