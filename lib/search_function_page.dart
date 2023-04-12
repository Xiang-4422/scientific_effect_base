import 'package:flutter/material.dart';

class SearchFunctionPage extends StatelessWidget {
  const SearchFunctionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("功能查询"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Text("选择一项操作类型以及要操作的对象，然后点击提交查询"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 操作类型选择
              Container(
                height:  MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
                child:  Wrap(
                  spacing: 8.0, // 主轴(水平)方向间距
                  runSpacing: 4.0, // 纵轴（垂直）方向间距
                  alignment: WrapAlignment.center, //沿主轴方向居中
                  children: <Widget>[
                    Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
                      label: Text('Hamilton'),
                    ),
                    Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
                      label: Text('Lafayette'),
                    ),
                    Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
                      label: Text('Mulligan'),
                    ),
                    Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
                      label: Text('Laurens'),
                    ),
                  ],
                ),
              ),
              // 操作对象选择
              Container(
                height:  MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                    color: Colors.white70
                ),
                child: Text("操作对象"),
              ),
              // 结果类型
              Container(
                height:  MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                    color: Colors.white70
                ),
                child: Text("结果类型"),
              ),
            ],
          ),
          ElevatedButton(onPressed: (){}, child: Text("提交查询")),
        ],
      ),
    );
  }
}