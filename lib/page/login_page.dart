import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whale/component/base_padding.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: BasePadding(
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 128,
                  ),
                  Text(
                    "孤岛鲸鱼",
                    style: TextStyle(
                      color: CupertinoColors.black,
                      fontSize: CupertinoTheme.of(context)
                          .textTheme
                          .navLargeTitleTextStyle
                          .fontSize,
                      fontWeight: CupertinoTheme.of(context)
                          .textTheme
                          .navLargeTitleTextStyle
                          .fontWeight,
                    ),
                  ),
                  Container(
                    height: 16,
                  ),
                  Text(
                    "\"可能\"是一个时间管理软件。",
                    style: TextStyle(
                      color: CupertinoColors.secondaryLabel,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: CupertinoColors.systemGrey5,
                        ),
                      ),
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                          flex: 1,
                          child: CupertinoTextField.borderless(
                            placeholder: "手机号",
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 19),
                          ),
                        ),
                        CupertinoButton(
                          child: Text("获取验证码"),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  CupertinoTextField(
                    placeholder: "短信验证码",
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 19),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: CupertinoColors.systemGrey5,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(14),
                    child: Text("登录"),
                    onPressed: () {},
                  ),
                  Container(
                    height: 80,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
