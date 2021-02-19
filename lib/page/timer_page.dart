import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:whale/model/av_file_entity.dart';
import 'package:whale/model/timer_card_category_entity.dart';
import 'package:whale/model/timer_card_entity.dart';
import 'package:whale/page/timer_card_add_page.dart';
import 'package:whale/page/timer_counting_page.dart';
import 'package:whale/type/timer_card_configuration.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  List<TimerCardEntity> timerCardList;

  Future<List<LCObject>> queryTimerCard() {
    LCQuery query = LCQuery("TimerCard");
    query.include("category.backgroundImage");
    return query.find();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timerCardList = [];
    _getData();
  }

  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: timerCardList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Hero(
                tag: "timer_card",
                child: Text('1'),
              ),
              onTap: () {
                var route = PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return TimerCountingPage(
                      timerCardConfiguration: TimerCardConfiguration(
                        height: 500,
                        isCountingMode: true,
                      ),
                    );
                  },
                );
                Navigator.of(context).push(route);
              },
            );
          },
        ),
      ),
    );
  }

  // 第一次进入和加载更多时
  _getData() async {
    try {
      var response = await queryTimerCard();
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
    } catch (e) {
      print(e);
    }
  }
}
