import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import 'detial_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.param1, required this.param2, required this.category}) : super(key: key);

  final String category;
  final String param1;
  final String param2;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  
  late List searchResult = [];
  late String param1EN;
  late String param2EN;

  @override
  void initState() {
    super.initState();
    param1EN = RegExp(r'(?<=\()[^]+(?=\))').firstMatch(widget.param1)!.group(0)!;
    param2EN = RegExp(r'(?<=\()[^]+(?=\))').firstMatch(widget.param2)!.group(0)!;
    initData(param1EN, param2EN);
  }
  initData (String param1, String param2) async {
    final conn = await MySQLConnection.createConnection(
      host: "47.109.68.30",
      port: 3306,
      userName: "xy",
      password: "123156Xy.",
      databaseName: "effects_database", // optional
    );
    await conn.connect();
    var result = await conn.execute(
        "select a.name, a.detail "
        "from effects as a "
        "inner join querys as b on a.id = b.effect_id "
        "where b.param1 = '$param1' and b.param2 = '$param2'"
    );
    for(var row in result.rows) {
      var rowResultMap = row.assoc();
      searchResult.add([rowResultMap["name"], rowResultMap["detail"]]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("查询结果"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: ListView(
          children: searchResult == [] ? [Text("请等待")]: searchResult.map((e) => Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(effectName: e[0], param1: param1EN, param2: param2EN, category: widget.category,)));
                  },
                  child: ListTile(
                    title: Text(
                      e[0],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(e[1]),
                  ),
                ),
          )).toList()
        ),
      ),
    );
  }



}
