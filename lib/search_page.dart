import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title, required this.prompt, required this.choices, required this.options}) : super(key: key);

  final String title;
  final String prompt;
  final List<String> options;
  final Map<String, List<String>> choices;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  late String title;
  late String prompt;
  late List<String> options;
  late Map<String, List<String>> choices;
  var choosedItem;


  @override
  void initState() {
    title = widget.title;
    prompt = widget.prompt;
    options = widget.options;
    choices = widget.choices;
    choosedItem = {options[0] : "", options[1] : ""};
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Text(prompt),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildContainer(options[0]),
              _buildContainer(options[1]),
            ],
          ),
          ElevatedButton(onPressed: (){}, child: Text("提交查询")),
        ],
      ),
    );
  }

  Widget _buildContainer (String name) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(name),
          Container(
            padding: EdgeInsets.all(20),
            height:  MediaQuery.of(context).size.height/4,
            child:  Wrap(
                spacing: 8.0, // 主轴(水平)方向间距
                runSpacing: 4.0, // 纵轴（垂直）方向间距
                direction: Axis.vertical,
                alignment: WrapAlignment.center, //沿主轴方向居中
                children: choices[name]!.map((e) => GestureDetector(
                  onTap: () => setState(() {
                    choosedItem[name] = e;
                  }),
                  child: Chip(
                    avatar: Visibility(
                      visible: e == choosedItem[name],
                      child: const CircleAvatar(
                          backgroundColor: Colors.blue,
                      ),
                    ),
                    label: Text(e),
                  ),
                )).toList()),
          ),
        ],
      ),
    );
  }

}