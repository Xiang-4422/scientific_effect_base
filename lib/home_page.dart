import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:ui';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  late double screenWidth;
  late double screenHeight;

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
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "searchFunctionPage"),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.cyanAccent,
                          ),
                          width:  MediaQuery.of(context).size.height/4,
                          height: MediaQuery.of(context).size.width/8,
                          alignment: Alignment.center,
                          child: Text(
                            "功能",
                          ),
                        ),
                      ),
                      Text("例如：移动 液体"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "searchParameterPage"),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.cyanAccent,
                          ),
                          width:  MediaQuery.of(context).size.height/4,
                          height: MediaQuery.of(context).size.width/8,
                          alignment: Alignment.center,
                          child: Text("参数"),
                        ),
                      ),
                      Text("例如：增加 温度"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "searchConvertPage"),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.cyanAccent,
                          ),
                          width:  MediaQuery.of(context).size.height/4,
                          height: MediaQuery.of(context).size.width/8,
                          alignment: Alignment.center,
                          child: Text("转换"),
                        ),
                      ),
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
}
