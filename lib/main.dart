import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whale/component/global_counting_bar.dart';
import 'package:whale/page/timer_page.dart';
import 'package:whale/provider/current_timer_card.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentTimerCard()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: '孤岛鲸鱼',
      home: Consumer<CurrentTimerCard>(
        builder: (context, model, child) {
          return MyHomePage(title: '孤岛鲸鱼');
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.timer), label: "计时"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.quote_bubble), label: "书摘"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.photo_on_rectangle), label: "时刻"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_circle), label: "我"),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return SafeArea(
              child: Column(
                children: [
                  GlobalCountingBar(),
                  TimerPage(),
                ],
              ),
            );
            break;
          default:
            return Center(
              child: Text(index.toString()),
            );
        }
      },
    );
  }
}
