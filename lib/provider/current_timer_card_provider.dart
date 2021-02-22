import 'dart:async';

import 'package:flutter/cupertino.dart';

class CurrentTimerCardProvider extends ChangeNotifier {
  String timerCardId;
  String timerCardName;
  DateTime startAt;
  bool isCounting;
  Timer timer;
  String countingText = "00:00:00"; // 转换过的时间显示，如：02:12:13
  CurrentTimerCardProvider({this.isCounting = false, this.timerCardName = "未传入TimerCardName"});

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _resetCountingText(){
    this.countingText = "00:00:00";
  }
  void setTimerCardName(String name) {
    this.timerCardName = name;
    notifyListeners();
  }

  void setCountingTimerCardId(String timerCardObjectId){
    this.timerCardId = timerCardObjectId;
    notifyListeners();
  }

  void startCount() {
    _resetCountingText();
    this.isCounting = true;
    this.startAt = DateTime.now();
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      this.countingText = _printDuration(DateTime.now().difference(this.startAt));
      notifyListeners();
    });
    notifyListeners();
  }

  void cancelCount(){
    this.isCounting = false;
    this.timer.cancel();
    notifyListeners();
  }
}
