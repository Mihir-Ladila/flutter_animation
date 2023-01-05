// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:widget_to_photo/pages/home.dart';
import 'package:widget_to_photo/temp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempPage(title: 'Test'),
    );
  }
}
