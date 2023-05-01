import 'package:flutter/material.dart';
import 'package:scientific_effect_base/result_page.dart';
import 'package:motion_toast/motion_toast.dart';


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
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(title + "查询"),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            Text(
              prompt,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                _buildContainer(options[0]),
                _buildContainer(options[1]),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              onPressed: (){
                if (choosedItem[options[0]] == "" || choosedItem[options[0]] == "") {
                  MotionToast.warning(
                    title:  Text("未选择查询参数"),
                    description: Text("需要选择好参数后查询"),
                  ).show(context);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ResultPage(param1: choosedItem[options[0]], param2: choosedItem[options[1]], category: title,)));
                }
              },
              child: Text("提交查询"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer (String name) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(name),
          Container(
            padding: EdgeInsets.all(10),
            height:  MediaQuery.of(context).size.height/4,
            child:  MediaQuery.of(context).size.width < 1200
                ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                  spacing: 4.0, // 主轴(水平)方向间距
                  runSpacing: 4.0, // 纵轴（垂直）方向间距
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center, //沿主轴方向居中
                  children: choices[name]!.map((e) => GestureDetector(
                    onTap: () => setState(() {
                      choosedItem[name] = e;
                    }),
                    child: Chip(
                      backgroundColor: e == choosedItem[name] ? Colors.green : Colors.grey[200],
                      label: Text(e),
                    ),
                  )).toList()),
                )
                : Wrap(
                spacing: 4.0, // 主轴(水平)方向间距
                runSpacing: 4.0, // 纵轴（垂直）方向间距
                direction: Axis.vertical,
                alignment: WrapAlignment.center, //沿主轴方向居中
                children: choices[name]!.map((e) => GestureDetector(
                  onTap: () => setState(() {
                    choosedItem[name] = e;
                  }),
                  child: Chip(
                    backgroundColor: e == choosedItem[name] ? Colors.green : Colors.grey[200],
                    label: Text(e),
                  ),
                )).toList()),
          ),
        ],
      ),
    );
  }

}