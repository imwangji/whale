import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';

class UserProvider extends ChangeNotifier {
  LCUser currentUser;

  _check() async{
    LCUser currentUser = await LCUser.getCurrent();
    this.setCurrentUser(currentUser);
  }

  UserProvider(){
    _check();
  }
  setCurrentUser(LCUser user) {
    this.currentUser = user;
    notifyListeners();
  }

  Future<LCUser> loginByPhoneNumber(String phoneNumber, String smsCode) async {
    try {
      if (phoneNumber.isNotEmpty && smsCode.isNotEmpty) {
        return LCUser.signUpOrLoginByMobilePhone(phoneNumber, smsCode);
      } else {
        throw LCException(6261001001, "电话号码或验证码不正确");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> requestSMSCode(String phoneNumber) {
    try {
      return LCSMSClient.requestSMSCode(phoneNumber);
    } catch (e) {
      LCException exception = e;
      print(exception.message);
      throw e;
    }
  }
}
