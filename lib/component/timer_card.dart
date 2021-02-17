import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whale/type/timer_card_configuration.dart';

// ignore: must_be_immutable
class TimerCard extends StatefulWidget {
  TimerCardConfiguration configuration;

  TimerCard(configuration) {
    this.configuration = configuration;
  }

  @override
  _TimerCardState createState() => _TimerCardState();
}

class _TimerCardState extends State<TimerCard>
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

  Widget getRecordIconOrNot() {
    if (this.widget.configuration.isCountingMode) {
      return Container();
    } else {
      return Icon(
        CupertinoIcons.play_circle,
        color: Colors.white,
        size: 30,
      );
    }
  }

  Widget getCloseButtonOrNot(){
    if(this.widget.configuration.isCountingMode){
      return GestureDetector(
        child: Icon(CupertinoIcons.clear_circled_solid,color: CupertinoColors.white,),
        onTap: this.widget.configuration.onCloseButtonTapped,
      );
    }else{
      return Container();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(this.widget.configuration.backgroundImageUrl),
        ),
        color: Colors.cyan,
        borderRadius: this.widget.configuration.isCountingMode
            ? null
            : BorderRadius.circular(14),
      ),
      height: this.widget.configuration.height,
      margin:
          this.widget.configuration.isCountingMode ? null : EdgeInsets.all(16),
      padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 16),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    this.widget.configuration.categoryName,
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.extraLightBackgroundGray,
                    ),
                  ),
                  getCloseButtonOrNot(),
                ],
              ),
              Text(
                this.widget.configuration.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.extraLightBackgroundGray,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1天3小时3分钟",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.extraLightBackgroundGray,
                ),
              ),
              getRecordIconOrNot(),
            ],
          ),
        ],
      ),
    );
  }
}
