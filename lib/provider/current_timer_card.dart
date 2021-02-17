import 'package:flutter/cupertino.dart';

class CurrentTimerCard extends ChangeNotifier{
  String timerCardId;
  DateTime startAt;
  bool isCounting;
  void setStartTime(DateTime startAt){
    this.isCounting = true;
    this.startAt = startAt;
    notifyListeners();
  }
  void clearCounting(){
    this.isCounting = false;
    notifyListeners();
  }
}
