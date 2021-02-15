import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whale/page/timer_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
          BottomNavigationBarItem(icon: Icon(Icons.timer)),
          BottomNavigationBarItem(icon: Icon(Icons.format_quote_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.photo_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined)),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return TimerPage();
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
