import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whale/component/timer_card.dart';
import 'package:whale/provider/current_timer_card_provider.dart';
import 'package:whale/type/timer_card_configuration.dart';

// ignore: must_be_immutable
class TimerCountingPage extends StatefulWidget {
  TimerCardConfiguration timerCardConfiguration;
  String heroAnimationTag = "";
  TimerCountingPage({@required this.timerCardConfiguration,@required this.heroAnimationTag});

  @override
  _TimerCountingPageState createState() => _TimerCountingPageState();
}

class _TimerCountingPageState extends State<TimerCountingPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Timer timer;
  String countingText;


  String getDisplayCountingText() {
    if(Provider.of<CurrentTimerCardProvider>(context,listen: false).isCounting &&
        Provider.of<CurrentTimerCardProvider>(context,listen: false).timerCardId == this.widget.timerCardConfiguration.timerCardId){
      return Provider.of<CurrentTimerCardProvider>(context,listen: false).countingText;
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

  // 是否是当前正在计时的卡片
  bool isCurrentCountingTimerCard(){
    return Provider.of<CurrentTimerCardProvider>(context,listen: false).isCounting &&
        Provider.of<CurrentTimerCardProvider>(context,listen: false).timerCardId == this.widget.timerCardConfiguration.timerCardId;
  }

  Widget getCountingIcon() {
    if (this.isCurrentCountingTimerCard()) {
      return GestureDetector(
        onTap: () {
          Provider.of<CurrentTimerCardProvider>(context,listen: false).cancelCount();
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
          if(Provider.of<CurrentTimerCardProvider>(context,listen: false).isCounting){
            return;
          }
          Provider.of<CurrentTimerCardProvider>(context,listen: false).setCountingTimerCardId(this.widget.timerCardConfiguration.timerCardId);
          Provider.of<CurrentTimerCardProvider>(context,listen: false).setTimerCardName(this.widget.timerCardConfiguration.name);
          Provider.of<CurrentTimerCardProvider>(context,listen: false).setTimerCardCategoryName(this.widget.timerCardConfiguration.categoryName);
          Provider.of<CurrentTimerCardProvider>(context,listen: false).setTimerCardTotalHourMinute(this.widget.timerCardConfiguration.totalTime);
          Provider.of<CurrentTimerCardProvider>(context,listen: false).setTimerCardBackgroundImageUrl(this.widget.timerCardConfiguration.backgroundImageUrl);
          Provider.of<CurrentTimerCardProvider>(context,listen: false).startCount();
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

    return Consumer<CurrentTimerCardProvider>(
      builder: (context, currentTimerCard, child) {
        return CupertinoPageScaffold(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      currentTimerCard.setIsNeedFetchNewTimerCardData(true);
                    },
                    child: Hero(
                      tag: this.widget.heroAnimationTag,
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
