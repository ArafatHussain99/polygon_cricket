import 'package:flutter/material.dart';
import 'package:polygon_cricket/score_card/controller/database_controller.dart';
import 'package:polygon_cricket/score_wheel/view/main_score_wheel_screen.dart';
import 'package:polygon_cricket/toss_screen/view/toss_screen.dart';
import 'package:sqflite/sqflite.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? hasData;
  bool? updated;
  bool? databaseAvailable;
  bool? matchInfoTableAvailable;

  // void _refreshJournals() async {
  //   await DatabaseHelper.open();
  //   await DatabaseHelper.createInfoTable();
  //   // final data = await DatabaseHelper.getItems();
  //   // setState(() {
  //   //   _journals = data;
  //   //   _isLoading = false;
  //   // });
  // }

  @override
  void initState() {
    super.initState();
    DatabaseHelper.dataBaseExists().then((value) {
      if (value == true) {
        DatabaseHelper.doesTableExist('infoTable').then((value) {
          if (value == true) {
            DatabaseHelper.isDataAvailable().then((value) {
              setState(() {
                print('isDataAvailable called, data: $value');
                hasData = value;
                if (hasData!) {
                  DatabaseHelper.updateInfo(context).then((value) {
                    setState(() {
                      print('update info called, data: $value');
                      updated = value;
                    });
                  });
                }
              });
            });
          }
          matchInfoTableAvailable = value;
        });
      }
      setState(() {
        print('DataBaseExists called, data: $value');
        databaseAvailable = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (databaseAvailable == null) {
      print('loading');
      // Render a loading indicator or any other placeholder widget
      return const Scaffold(body: CircularProgressIndicator());
    } else if ((!databaseAvailable!)) {
      // Navigate to the score wheel screen directly
      print('Toss screen with databaseAvailable: $databaseAvailable');
      return const TossScreen();
    } else if ((hasData != null && hasData == true) && databaseAvailable!) {
      print(
          'ScoreWheel screen with hasData: $hasData and databaseAvailable: $databaseAvailable');
      // Navigate to the score wheel screen directly
      if (updated == null) {
        return const Scaffold(body: CircularProgressIndicator());
      } else {
        return const ScoreWheel();
      }
    } else {
      // Render the toss screen content
      print(
          'ScoreWheel screen with hasData: $hasData and databaseAvailable: $databaseAvailable');

      return const TossScreen();
    }
  }
}
