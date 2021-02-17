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
              TimerCardConfiguration(
                isWithMargin: true,
                isWithBorderRadius: true,
              ),
            ),
          ),
          onTap: () {
            var route = PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return TimerCountingPage();
              },
            );
            Navigator.of(context).push(route);
          },
        ),
      ),
    );
  }
}
