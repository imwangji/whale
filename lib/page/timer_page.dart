import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whale/component/timer_card.dart';
import 'package:whale/page/timer_card_add_page.dart';
import 'package:whale/page/timer_counting_page.dart';
import 'package:whale/type/timer_card_configuration.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
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
        child: GestureDetector(
          child: Hero(
            tag: "timer_card",
            child: TimerCard(
              TimerCardConfiguration(),
            ),
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
        ),
      ),
    );
  }
}
