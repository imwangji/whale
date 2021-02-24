import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:whale/component/base_padding.dart';
import 'package:whale/provider/user_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var phoneController = TextEditingController();
  var smsCodeController = TextEditingController();
  var smsCodeCountTimer;
  var smsCodeCountNumber;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
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
                              child: CupertinoTextField(
                                decoration: BoxDecoration(color: CupertinoColors.white,border: Border.all(width: 0,color: CupertinoColors.white)),
                                controller: phoneController,
                                placeholder: "手机号",
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 19),
                              ),
                            ),
                            CupertinoButton(
                              child: Text("获取验证码"),
                              onPressed: () {
                                if (phoneController.value.text.isNotEmpty) {
                                  userProvider.requestSMSCode(
                                      phoneController.value.text);
                                  Toast.show("验证码已发送", context,
                                      gravity: Toast.CENTER);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      CupertinoTextField(
                        placeholder: "短信验证码",
                        controller: smsCodeController,
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 19),
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
                        onPressed: () async {
                          if (phoneController.value.text.isNotEmpty &&
                              smsCodeController.value.text.isNotEmpty) {
                            try {
                              LCUser user =
                                  await userProvider.loginByPhoneNumber(
                                      phoneController.value.text,
                                      smsCodeController.value.text);
                              userProvider.setCurrentUser(user);
                            } catch (e) {
                              LCException exception = e;
                              Toast.show(exception.message, context);
                            }
                          }
                        },
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
      },
    );
  }
}
