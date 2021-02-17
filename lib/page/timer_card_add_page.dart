import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whale/component/text_label_arrow.dart';

class TimerCardAddPage extends StatefulWidget {
  @override
  _TimerCardAddPageState createState() => _TimerCardAddPageState();
}

class _TimerCardAddPageState extends State<TimerCardAddPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text("添加计时项目"),
        trailing: GestureDetector(
          onTap: (){},
          child: Text("完成",style: TextStyle(color: CupertinoColors.activeBlue),),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            TextLabelArrow(text: "项目名称",label: "学习angular",onTap: (){print(123);},)
          ],
        ),
      ),
    );
  }
}
