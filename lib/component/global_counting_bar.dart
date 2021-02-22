import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:whale/page/timer_counting_page.dart';
import 'package:whale/provider/current_timer_card_provider.dart';
import 'package:whale/type/timer_card_configuration.dart';

class GlobalCountingBar extends StatefulWidget {
  @override
  _GlobalCountingBarState createState() => _GlobalCountingBarState();
}

class _GlobalCountingBarState extends State<GlobalCountingBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentTimerCardProvider>(
      builder: (context, currentTimerCard, child) {
        return currentTimerCard.isCounting
            ? GestureDetector(
                onTap: (){
                  var route = PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return TimerCountingPage(
                        heroAnimationTag: currentTimerCard.timerCardId,
                        timerCardConfiguration: TimerCardConfiguration(
                          timerCardId: currentTimerCard.timerCardId,
                          name: currentTimerCard.timerCardName,
                          height: 500,
                          isCountingMode: true,
                          categoryName: currentTimerCard.timerCardCategoryName,
                          totalTime: currentTimerCard.timerCardTotalHourMinute,
                          backgroundImageUrl: currentTimerCard.timerCardBackgroundImageUrl,
                        ),
                      );
                    },
                  );
                  Navigator.of(context).push(route);
                },
                child: Container(
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
                ),
              )
            : Container();
      },
    );
  }
}
