import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whale/component/timer_card.dart';
import 'package:whale/provider/current_timer_card.dart';
import 'package:whale/type/timer_card_configuration.dart';

class TimerCountingPage extends StatefulWidget {
  TimerCardConfiguration timerCardConfiguration;

  TimerCountingPage({@required this.timerCardConfiguration});

  @override
  _TimerCountingPageState createState() => _TimerCountingPageState();
}

class _TimerCountingPageState extends State<TimerCountingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Timer timer;
  String countingText;

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
  String getDisplayCountingText() {
    if(Provider.of<CurrentTimerCard>(context,listen: false).isCounting){
      CurrentTimerCard currentTimerCard = Provider.of<CurrentTimerCard>(context,listen: false);
      Duration durationTime = DateTime.now().difference(currentTimerCard.startAt);
      return _printDuration(durationTime);
    }else{
      return "00:00:00";
    }
  }
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

  Widget getCountingIcon() {
    if (Provider.of<CurrentTimerCard>(context,listen: false).isCounting) {
      return GestureDetector(
        onTap: () {
          Provider.of<CurrentTimerCard>(context,listen: false).clearCounting();
          this.timer.cancel();
        },
        child: Icon(
          CupertinoIcons.stop_circle,
          size: 60,
          color: CupertinoColors.systemPink,
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Provider.of<CurrentTimerCard>(context,listen: false).setTimerCardName(this.widget.timerCardConfiguration.name);
          Provider.of<CurrentTimerCard>(context,listen: false).setStartTime(DateTime.now());
          this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
            setState(() {
              this.countingText = DateTime.now().difference(Provider.of<CurrentTimerCard>(context,listen: false).startAt).toString();
            });
          });
        },
        child: Icon(
          CupertinoIcons.play_circle,
          size: 60,
          color: CupertinoColors.systemPink,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<CurrentTimerCard>(
      builder: (context, currentTimerCard, child) {
        return CupertinoPageScaffold(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () {
                      this.timer.cancel();
                      Navigator.pop(context);
                    },
                    child: Hero(
                      tag: "timer_card",
                      child: TimerCard(this.widget.timerCardConfiguration),
                    ),
                  ),
                ),
                Expanded(
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        this.getDisplayCountingText(),
                        style: TextStyle(
                          fontSize: 46,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      getCountingIcon(),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "回到主界面不会打断计时",
                        style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.secondaryLabel),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
