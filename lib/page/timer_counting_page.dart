import 'package:flutter/cupertino.dart';
import 'package:whale/component/timer_card.dart';
import 'package:whale/type/timer_card_configuration.dart';

class TimerCountingPage extends StatefulWidget {
  @override
  _TimerCountingPageState createState() => _TimerCountingPageState();
}

class _TimerCountingPageState extends State<TimerCountingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Hero(
              tag: "timer_card",
              child: TimerCard(
                TimerCardConfiguration(
                  isWithMargin: false,
                  isWithBorderRadius: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
