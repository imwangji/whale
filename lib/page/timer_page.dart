import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:provider/provider.dart';
import 'package:whale/component/wrapped_timer_card.dart';
import 'package:whale/model/av_file_entity.dart';
import 'package:whale/model/timer_card_category_entity.dart';
import 'package:whale/model/timer_card_entity.dart';
import 'package:whale/page/timer_card_add_page.dart';
import 'package:whale/provider/current_timer_card_provider.dart';
import 'package:whale/provider/user_provider.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  List<TimerCardEntity> timerCardList;

  Future<List<LCObject>> queryTimerCard(LCUser currentUser) {
    LCQuery query = LCQuery("TimerCard");
    query.include("category.backgroundImage");
    query.whereEqualTo("user", currentUser);
    return query.find();
  }

  @override
  void initState() {
    super.initState();
    timerCardList = [];
    _getData(Provider.of<UserProvider>(context,listen: false).currentUser);
  }

  // 第一次进入和加载更多时
  _getData(LCUser currentUser) async {
    try {
      var response = await queryTimerCard(currentUser);
      List<TimerCardEntity> _timerCardList = [];
      response.forEach((element) {
        _timerCardList.add(
          TimerCardEntity(
            objectId: element.objectId,
            name: element["name"],
            totalTime: element["totalTime"],
            category: TimerCardCategoryEntity(
              name: element["category"]["name"],
              backgroundImage: AVFileEntity(
                url: element["category"]["backgroundImage"]["url"],
              ),
            ),
          ),
        );
      });
      setState(() {
        timerCardList = _timerCardList;
      });
      Provider.of<CurrentTimerCardProvider>(context,listen: false).setIsNeedFetchNewTimerCardData(false);
    } catch (e) {
      print(e);
    }
  }

  Widget renderEmptyContentOrList() {
    if (this.timerCardList.isEmpty) {
      return Center(
        child: Text(
          '还没有任务，添加一个吧',
          style: TextStyle(color: CupertinoColors.systemGrey3),
        ),
      );
    } else {
      return Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: timerCardList.length,
            itemBuilder: (context, index) {
              var currentElement = timerCardList.elementAt(index);
              return WrappedTimerCard(
                heroTag: currentElement.objectId,
                name: currentElement.name,
                categoryName: currentElement.category.name,
                backgroundImageUrl: currentElement.category.backgroundImage.url,
                totalTime: currentElement.totalTime,
              );
            },
          ),
        ],
      );
    }
  }

  /// 渲染函数
  @override
  Widget build(BuildContext context) {

    return Consumer2<UserProvider,CurrentTimerCardProvider>(
      builder: (context, userProvider,currentTimerCardProvider, child) {
        if(currentTimerCardProvider.isNeedFetchNewTimerCardData){
          _getData(userProvider.currentUser);
        }
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.white,
            leading: Text(
              "时间",
              style: TextStyle(
                fontSize: CupertinoTheme.of(context)
                    .textTheme
                    .navLargeTitleTextStyle
                    .fontSize,
                fontWeight: CupertinoTheme.of(context)
                    .textTheme
                    .navLargeTitleTextStyle
                    .fontWeight,
              ),
            ),
            border: Border(bottom: BorderSide(color: Colors.transparent)),
            trailing: CupertinoButton(
              child: Icon(CupertinoIcons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => TimerCardAddPage(),
                  ),
                );
              },
            ),
          ),
          child: SafeArea(
            child: renderEmptyContentOrList(),
          ),
        );
      },
    );
  }
}
