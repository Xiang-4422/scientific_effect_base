import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:scientific_effect_base/search_page.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  late double screenWidth;
  late double screenHeight;

  var searchPageData = [
    ["功能查询", "提示", ["操作类型","操作对象"], {"操作类型" : ["1", "2", "1", "2", "1", "2", "1", "2", "1", "2", "1", "2", "1", "2", "1", "2", ], "操作对象": ["1","2"]}],
    ["参数查询", "提示", ["操作类型","操作参数"], {"操作类型" : ["1","2"], "操作参数": ["1","2"]}],
    ["转换查询", "提示", ["转换前类型","转换后类型"], {"转换前类型" : ["1","2"], "转换后类型": ["1","2"]}],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "科学原理数据库"
        ),
        actions: [
          IconButton(
            onPressed: () {Navigator.pushNamed(context, "addPage");},
            icon: Icon(Icons.add),
            tooltip: "添加科学效应",

          )
        ],
      ),
      body: Column(
        children: [
          Text("选择你要查询的科学效应类型"),
          // 选择搜索方式
          Expanded(
            child: Container(
              color: Colors.white12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOptions(0, "功能"),
                      Text("例如：移动 液体"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOptions(1, "参数"),
                      Text("例如：增加 温度"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOptions(2, "转换"),
                      Text("例如：机械能 转换为 动能"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions(int index, String title) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SearchPage(
            title: searchPageData[index][0] as String,
            prompt: searchPageData[index][1] as String,
            choices: searchPageData[index][3] as Map<String, List<String>>,
            options: searchPageData[index][2] as List<String>,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.cyanAccent,
        ),
        width: MediaQuery.of(context).size.height / 4,
        height: MediaQuery.of(context).size.width / 8,
        alignment: Alignment.center,
        child: Text(title),
      ),
    );
  }
}
