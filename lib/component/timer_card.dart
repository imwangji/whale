import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whale/type/timer_card_configuration.dart';

// ignore: must_be_immutable
class TimerCard extends StatefulWidget {
  TimerCardConfiguration configuration;
  // ignore: empty_constructor_bodies
  TimerCard(this.configuration) {}
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: this.widget.configuration.isWithBorderRadius
            ? BorderRadius.circular(14)
            : null,
      ),
      height: 242,
      margin:
          this.widget.configuration.isWithMargin ? EdgeInsets.all(16) : null,
    );
  }
}
