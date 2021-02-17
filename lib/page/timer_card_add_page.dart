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
          onTap: () {},
          child: Text(
            "完成",
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            TextLabelArrow(
              text: "名称",
              label: "",
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text("名称"),
                      ),
                      content: CupertinoTextField(),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('取消'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text('确定'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  },
                );
              },
            ),
            Divider(
              height: 1,
            ),
            TextLabelArrow(
              text: "分类",
              label: "",
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                            onPressed: () {}, child: Text("学习")),
                        CupertinoActionSheetAction(
                            onPressed: () {}, child: Text("娱乐")),
                        CupertinoActionSheetAction(
                            onPressed: () {}, child: Text("工作")),
                        CupertinoActionSheetAction(
                            onPressed: () {}, child: Text("琐碎")),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
