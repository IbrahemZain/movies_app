import 'package:flutter/material.dart';
import 'package:movies/screens/home_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movies App',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: HomeScreen(),
    );
  }
}
