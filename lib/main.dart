import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '科学原理知识库',
      routes: {
        "/": (context) => HomePage(),
        "resultPage": (context) => HomePage(),
      },
    );
  }
}