import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                  Container(
                    alignment: Alignment.centerLeft,
                    margin:EdgeInsets.only(left: 16,right: 16,bottom: 8),
                    padding:EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("angular学习中",style: TextStyle(color: CupertinoColors.white),),
                        Text("0:12:12",style: TextStyle(color: CupertinoColors.white),),
                      ],
                    )
                  ),
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
