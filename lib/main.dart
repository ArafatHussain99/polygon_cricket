import 'package:flutter/material.dart';
import 'package:polygon_cricket/routes.dart';
import 'package:polygon_cricket/toss_screen/view/toss_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const TossScreen(),
    );
  }
}
