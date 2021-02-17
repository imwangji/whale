class TimerCardConfiguration {
  bool isCountingMode;
  String backgroundImageUrl;
  int totalTime;
  String name;
  String categoryName;
  double height;
  Function onCloseButtonTapped;
  // ignore: empty_constructor_bodies
  TimerCardConfiguration({
    this.isCountingMode = false,
    this.backgroundImageUrl = "http://lc-a2nvo31p.cn-n1.lcfile.com/ff21d25a1d7edc97bd7e.png/Open%20Doodles%20-%20Studying.png",
    this.totalTime = 0,
    this.name = "学习Angular",
    this.height = 260,
    this.categoryName = "学习",
    this.onCloseButtonTapped,
  });
}
