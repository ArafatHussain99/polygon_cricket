import 'package:flutter/material.dart';
import 'package:polygon_cricket/batsman_select_screen/view/batsman_select.dart';
import 'package:polygon_cricket/bowler_select_screen/view/bowler_select.dart';
import 'package:polygon_cricket/score_card/view/scorecard.dart';
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
    case ScoreCard.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ScoreCard(),
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
