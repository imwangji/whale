import 'package:whale/model/timer_card_category_entity.dart';

class TimerCardEntity {
  String objectId;
  String createdAt;
  String updateAt;
  String name;
  TimerCardCategoryEntity category;
  int totalTime;

  TimerCardEntity(
      {this.name,
      this.category,
      this.totalTime,
      this.objectId,
      this.createdAt,
      this.updateAt});
}
