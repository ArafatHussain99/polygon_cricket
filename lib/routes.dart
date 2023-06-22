import 'package:flutter/material.dart';
import 'package:polygon_cricket/batsman_select_screen/view/batsman_select.dart';
import 'package:polygon_cricket/bowler_select_screen/view/bowler_select.dart';
import 'package:polygon_cricket/score_wheel/view/scorewheel.dart';
import 'package:polygon_cricket/toss_screen/view/toss_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case BatsmanSelectScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BatsmanSelectScreen(),
      );
    case TossScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => TossScreen(),
      );
    case ScoreWheel.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ScoreWheel(),
      );
    case BowlerSelectingScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BowlerSelectingScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist..'),
          ),
        ),
      );
  }
}
