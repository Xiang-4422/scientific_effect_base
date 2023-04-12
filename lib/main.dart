import 'package:flutter/material.dart';
import 'package:scientific_effect_base/add__page.dart';
import 'package:scientific_effect_base/search_convert_page.dart';
import 'package:scientific_effect_base/search_function_page.dart';
import 'package:scientific_effect_base/search_parameter_page.dart';

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
        "searchParameterPage": (context) => SearchParameterPage(),
        "searchFunctionPage": (context) => SearchFunctionPage(),
        "searchConvertPage": (context) => SearchConvertPage(),
        "resultPage": (context) => HomePage(),
        "addPage": (context) => AddPage(),
      },
    );
  }
}