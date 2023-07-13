import 'package:flutter/material.dart';
import 'package:polygon_cricket/dummy_pagge/splash_screen.dart';
import 'package:polygon_cricket/routes.dart';

void main() {
  // bool hasData = await DatabaseHelper.isDataAvailable();
  // print(hasData);
  runApp(const MyApp(
      //hasData: hasData,
      ));
}

class MyApp extends StatelessWidget {
  //final bool hasData;
  const MyApp({
    super.key,
    /*required this.hasData*/
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const SplashScreen(),
    );
  }
}
