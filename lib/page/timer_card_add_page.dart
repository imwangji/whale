import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whale/component/base_padding.dart';

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
            Container(
              color: CupertinoColors.white,
              child: BasePadding(
                child: Row(
                  children: [
                    Expanded(
                      child: Text("项目名称"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12, left: 12),
                      child: Text(
                        "学习angular",
                        style: TextStyle(
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.right_chevron,
                      size: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
