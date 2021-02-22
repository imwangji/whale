import 'package:flutter/cupertino.dart';
import 'package:whale/component/timer_card.dart';
import 'package:whale/page/timer_counting_page.dart';
import 'package:whale/type/timer_card_configuration.dart';

class WrappedTimerCard extends StatefulWidget {
  String heroTag;
  String name;
  String categoryName;
  int totalTime;
  String backgroundImageUrl;
  WrappedTimerCard({
    this.heroTag,
    this.name,
    this.categoryName,
    this.totalTime,
    this.backgroundImageUrl
});
  @override
  _WrappedTimerCardState createState() => _WrappedTimerCardState();
}

class _WrappedTimerCardState extends State<WrappedTimerCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(
        tag: this.widget.heroTag,
        child: TimerCard(
          TimerCardConfiguration(
            name: this.widget.name,
            categoryName:this.widget.categoryName,
            totalTime: this.widget.totalTime,
            backgroundImageUrl: this.widget.backgroundImageUrl,
          ),
        ),
      ),
      onTap: () {
        var route = PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return TimerCountingPage(
              heroAnimationTag: this.widget.heroTag,
              timerCardConfiguration: TimerCardConfiguration(
                height: 500,
                isCountingMode: true,
                categoryName:this.widget.categoryName,
                totalTime: this.widget.totalTime,
              ),
            );
          },
        );
        Navigator.of(context).push(route);
      },
    );
  }
}
