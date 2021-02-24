import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:provider/provider.dart';
import 'package:whale/component/text_label_arrow.dart';
import 'package:whale/provider/user_provider.dart';

class TimerCardAddPage extends StatefulWidget {
  @override
  _TimerCardAddPageState createState() => _TimerCardAddPageState();
}

class _TimerCardAddPageState extends State<TimerCardAddPage> {
  String timerCardName = "";
  String timerCardCategoryName = "";
  TextEditingController timerCardNameController = TextEditingController();
  UserProvider userProvider;
  _checkFinishButtonAvailable() {
    if (timerCardName.isEmpty || timerCardCategoryName.isEmpty) {
      return null;
    } else {
      return () async {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: CupertinoActivityIndicator(),
              );
            });
        LCQuery<LCObject> query = LCQuery("TimerCardCategory");
        query.whereEqualTo('name', timerCardCategoryName);
        try {
          LCObject category = await query.first();
          if (category == null) {
            throw "没找到这个分类";
          } else {
            LCObject timerCard = LCObject("TimerCard");
            timerCard["name"] = timerCardName;
            timerCard["category"] = category;
            timerCard["user"] = this.userProvider.currentUser;
            await timerCard.save();
            // todo 用 popUntil 替换两次 pop
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        } catch (e) {
          Navigator.of(context).pop();
          showCupertinoDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text("发生错误"),
                );
              });
        }
      };
    }
  }

  _getFinishButtonStyle() {
    if (timerCardName.isEmpty || timerCardCategoryName.isEmpty) {
      return TextStyle(color: CupertinoColors.systemGrey2);
    } else {
      return TextStyle(color: CupertinoColors.activeBlue);
    }
  }

  @override
  Widget build(BuildContext context) {
    this.userProvider = Provider.of<UserProvider>(context,listen: false);
    return Consumer<UserProvider>(builder: (context,userProvider,child){
      return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        navigationBar: CupertinoNavigationBar(
          middle: Text("添加计时项目"),
          trailing: GestureDetector(
            onTap: _checkFinishButtonAvailable(),
            child: Text(
              "完成",
              style: _getFinishButtonStyle(),
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              TextLabelArrow(
                text: "名称",
                label: timerCardName,
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text("名称"),
                        ),
                        content: CupertinoTextField(
                          controller: timerCardNameController,
                        ),
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
                              setState(() {
                                this.timerCardName = timerCardNameController.text
                                    .toString()
                                    .trim();
                              });
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
                label: timerCardCategoryName,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  this.timerCardCategoryName = "娱乐";
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("娱乐")),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  this.timerCardCategoryName = "学习";
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("学习")),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  this.timerCardCategoryName = "工作";
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("工作")),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  this.timerCardCategoryName = "日常";
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("日常")),
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
    });
  }
}
