import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:provider/provider.dart';
import 'package:whale/component/global_counting_bar.dart';
import 'package:whale/page/login_page.dart';
import 'package:whale/page/timer_page.dart';
import 'package:whale/provider/current_timer_card_provider.dart';
import 'package:whale/provider/user_provider.dart';

Future<void> main() async {
  LeanCloud.initialize(
      'A2NVO31pitasJoNEmaIIMPTn-gzGzoHsz', 'l0AADzYKNDwBlfwumApsqNep',
      server: 'https://api.suoxue.today', queryCache: new LCQueryCache());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentTimerCardProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
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
      home: Consumer2<CurrentTimerCardProvider, UserProvider>(
        builder: (context, currentTimerCardProvider, userProvider, child) {
          if (userProvider.currentUser != null) {
            return MyHomePage(title: '孤岛鲸鱼');
          } else {
            return LoginPage();
          }
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
              child: Stack(
                children: [
                  Positioned(
                    child: GlobalCountingBar(),
                    top: 0,
                    left: 0,
                    right: 0,
                  ),
                  Positioned(
                    top: Provider.of<CurrentTimerCardProvider>(context)
                            .isCounting
                        ? 55
                        : 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: TimerPage(),
                  ),
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
