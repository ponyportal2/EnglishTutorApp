import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_youtube_api/screens/home_screen.dart';

void main() {
  runApp(MyApp());
  print(timings());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter YouTube API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
//        backgroundColor: Colors.black,
        canvasColor: Colors.grey[500],
      ),
      home: HomeScreen(),
    );
  }
}

String timings() {
  String contents = new File('assets/enjoy.dart').readAsStringSync();
  return (contents);
}
