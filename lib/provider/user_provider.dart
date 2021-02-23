import 'package:flutter/material.dart';
import 'package:leancloud_storage/leancloud.dart';

class UserProvider extends ChangeNotifier {
  LCUser currentUser;

  setCurrentUser(LCUser user){
    this.currentUser = user;
    notifyListeners();
  }
  loginByPhoneNumber(phoneNumber){
    notifyListeners();
  }

  requestSMSCode(phoneNumber){
    notifyListeners();
  }
}