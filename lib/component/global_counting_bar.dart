import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:whale/provider/current_timer_card_provider.dart';

class GlobalCountingBar extends StatefulWidget {
  @override
  _GlobalCountingBarState createState() => _GlobalCountingBarState();
}

class _GlobalCountingBarState extends State<GlobalCountingBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentTimerCard>(
      builder: (context, currentTimerCard, child) {
        return currentTimerCard.isCounting
            ? Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.activeGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentTimerCard.timerCardName,
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                    Text(
                      currentTimerCard.countingText,
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
