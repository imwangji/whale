import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:leancloud_storage/leancloud.dart';

class CurrentTimerCardProvider extends ChangeNotifier {
  String timerCardTotalHourMinute;
  String timerCardCategoryName;
  String timerCardId;
  String timerCardName;
  String timerCardBackgroundImageUrl;
  DateTime startAt;
  bool isCounting;
  Timer timer;
  String countingText = "00:00:00"; // 转换过的时间显示，如：02:12:13
  bool isNeedFetchNewTimerCardData = false;

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
  void setIsNeedFetchNewTimerCardData(bool isNeed){
    this.isNeedFetchNewTimerCardData = isNeed;
    if(this.isCounting){
      this.isNeedFetchNewTimerCardData = false;
    }
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

  void setTimerCardCategoryName(String timerCardCategoryName){
    this.timerCardCategoryName = timerCardCategoryName;
    notifyListeners();
  }
  void setTimerCardTotalHourMinute(String totalHourMinute){
    this.timerCardTotalHourMinute = totalHourMinute;
    notifyListeners();
  }
  void setTimerCardBackgroundImageUrl(String url){
    this.timerCardBackgroundImageUrl = url;
    notifyListeners();
  }
  void cancelCount() async{
    this.isCounting = false;
    this.timer.cancel();
    LCQuery query = LCQuery("TimerCard");
    query.whereEqualTo("objectId", timerCardId);
    LCObject timerCard = await query.first();
    var timeOfThisRecord = DateTime.now().difference(this.startAt).inMilliseconds;
    var existingTotalTime = timerCard["totalTime"];
    var newTotalTime = existingTotalTime+timeOfThisRecord;
    timerCard["totalTime"] = newTotalTime;
    await timerCard.save();
    notifyListeners();
  }
}
