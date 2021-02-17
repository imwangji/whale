import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whale/component/timer_card.dart';
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
  bool isCounting = false;
  DateTime startAt;
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

  Widget getCountingIcon(){
    if(this.isCounting){
      return GestureDetector(
        onTap: (){
          setState(() {
            this.isCounting = false;
          });
        },
        child: Icon(
          CupertinoIcons.stop_circle,
          size: 60,
          color: CupertinoColors.systemPink,
        ),
      );
    }else{
      return GestureDetector(
        onTap: (){
          setState(() {
            this.isCounting = true;
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
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              child: GestureDetector(
                onTap: () {
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
                    "0:00:00",
                    style: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(height: 20,),
                  getCountingIcon(),
                  Container(height: 50,),
                  Text(
                    "回到主界面不会打断计时",
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.secondaryLabel
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
