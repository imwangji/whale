import 'package:flutter/cupertino.dart';

class CurrentTimerCard extends ChangeNotifier {
  String timerCardId;
  String timerCardName;
  DateTime startAt;
  bool isCounting;

  CurrentTimerCard({this.isCounting = false,this.timerCardName="测试"});

  void setStartTime(DateTime startAt) {
    this.isCounting = true;
    this.startAt = startAt;
    notifyListeners();
  }

  void clearCounting() {
    this.isCounting = false;
    this.setTimerCardName(null);
    notifyListeners();
  }

  void setTimerCardName(String name) {
    this.timerCardName = name;
    notifyListeners();
  }
}
