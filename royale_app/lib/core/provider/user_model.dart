// Copyright 2019 Ucardstore LLC. All rights reserved.

import 'package:flutter/material.dart';
import 'package:royale_app/core/model/user.dart';

import '../../application.dart';

///Global user notifier model to monitor user data change.
///@author Moosphon

class UserModel extends ChangeNotifier {
  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel() {
    _user = Application.getUser();
  }

  // 更新数据
  updateUser(User user) {
    _user = user;
    notifyListeners();
    Application.putUser(user);
  }

  // 更新兴趣
  updateInterests(List<String> list) {
    _user.interests = list;
    Application.putUser(_user);
    notifyListeners();
  }

  // 更新用户具体信息
  updateUserArgument({
    String avatar,
    String birthday,
    int gender,
    String phone,
    int isPublic,
    List<String> interests
  }) {
    User temp = _user;
    if (avatar != null) {
      temp.avatar = avatar;
    }
    if (birthday != null) {
      temp.birthday = birthday;
    }
    if (gender != null) {
      temp.gender = gender;
    }
    if (interests != null) {
      temp.interests = interests;
    }
    if (phone != null) {
      temp.phone = phone;
    }
    if (isPublic != null) {
      temp.letterPublic = isPublic;
    }
    updateUser(temp);
  }

  // 清除数据
  clearUser() {
    _user = null;
    notifyListeners();
    Application.clearUser();
  }
}