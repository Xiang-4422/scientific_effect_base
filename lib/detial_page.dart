import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_markdown/flutter_markdown.dart';



class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.effectName, required this.param1, required this.param2, required this.category}) : super(key: key);

  final String category;
  final String param1;
  final String param2;
  final String effectName;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  
  TextEditingController _userInputController = TextEditingController();
  ScrollController _listViewController = ScrollController();

  late OpenAI openAI;

  late String prePrompt;
  late Message preMessage;
  var messages = <Message> [];
  bool isGenerating = true;

  @override
  void initState() {
    final String category = widget.category;
    final String param1 = widget.param1;
    final String param2 = widget.param2;
    final String effectName = widget.effectName;

    super.initState();

    // TODO： 配置角色
    prePrompt = category == "转换"
        // ? "我设计了一个triz科学效应知识库，可以通过不同的科学效应类型，根据所需要实现的目的来查询科学效应，你作为这个知识库的解说员，根据用户选择的目的以及科学效应来做具体的解说。"
        // "用户想要将$param1能转化为$param2，然后他选择的科学效应是$effectName。"
        // "你首先详细解释这个科学效应，然后结合用户的目的，举例这个科学效应的实际应用"
        // "格式如下：科学效应详解：... 科学效应应用实例：..."
        ? "来一段简单的java代码"
        : "我设计了一个triz科学效应知识库，可以通过不同的科学效应类型，根据所需要实现的目的来查询科学效应，你作为这个知识库的解说员，根据用户选择的目的以及科学效应来做具体的解说。"
        "用户想要$param1 $param2，然后他选择的科学效应是$effectName。"
        "你首先详细解释这个科学效应，然后结合用户的目的，举例这个科学效应的实际应用然后一条一条的列出来"
        "格式如下：科学效应详解：... 科学效应应用实例：..."
        "最后询问用户是否还有不懂的，如果有的话可以继续向你提问，你会尽力提供帮助";
    preMessage = Message(prePrompt, true);
    openAI = OpenAI.instance.build(token: "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",baseOption: HttpSetup(connectTimeout: const Duration(seconds: 20), receiveTimeout: const Duration(seconds: 20)),isLog: true);
    final request = ChatCompleteText(
        messages: [Map.of({"role": "user", "content": prePrompt})],
        maxToken: 1000,
        model: ChatModel.gptTurbo
    );
    messages.add(Message("", false));
    openAI.onChatCompletionSSE(request: request).listen((it) {
      debugPrint(it.choices.last.finishReason);
      setState(() {
        messages.last.content += it.choices.last.message!.content;
        // generatingAnswer += it.choices.last.message!.content;
      });
      if (it.choices.last.finishReason != null) {
        setState(() {
          isGenerating = false;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
            widget.effectName
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
              controller: _listViewController,
              children: messages.map((message) => Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width:  message.isMe ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      message.isMe ? Container() : Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.android),
                      ),
                      Expanded(
                        child: Container(
                          alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: MarkdownBody(
                                data: message.content,
                              ),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),).toList(),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(left: 40,top: 20 ,right: 40, bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: _userInputController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "请输入你的问题：",
                        labelStyle: TextStyle(
                          color: Colors.black, //设置labelText颜色
                        ),
                      ),
                    ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (!isGenerating && (_userInputController.text != "")){
                      // UI操作
                      setState(() {
                        messages.add(Message(_userInputController.text, true));
                        _userInputController.text = "";
                      });
                      _listViewController.animateTo(_listViewController.position.maxScrollExtent, duration: Duration(microseconds: 100), curve: Curves.easeInOut);
                      // chatGPT请求
                      final request = ChatCompleteText(
                          messages: [Map.of({"role": "user", "content": prePrompt}), ...messages.map((e) => Map.of({"role": e.isMe ? "user" : "assistant", "content": e.content}))],
                          maxToken: 1000,
                          model: ChatModel.gptTurbo
                      );
                      messages.add(Message("", false));
                      setState(() {
                        isGenerating = true;
                      });
                      openAI.onChatCompletionSSE(request: request).listen((it) {
                        setState(() {
                          messages.last.content += it.choices.last.message!.content;
                        });
                        if (it.choices.last.finishReason != null) {
                          setState(() {
                            isGenerating = false;
                          });
                        }
                      });
                    }
                 },
                )
              ],
            )
          )
        ],
      ),
    );
  }
}

class Message {
  Message(this.content, this.isMe);
  String content;
  final bool isMe;
}
