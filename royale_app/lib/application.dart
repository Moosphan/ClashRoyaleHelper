// Copyright 2019 Ucardstore LLC. All rights reserved.

import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/model/user.dart';
import 'core/resource/constants.dart';
import 'core/resource/shared_preference_keys.dart';
import 'core/util/log_utils.dart';

/// 全局应用配置
class Application {
  static SharedPreferences sp;
  //本地json数据存储
  static LocalStorage localStorage;
  static double screenWidth;
  static double screenHeight;

  static initialize() async {
    //_initSp();
    Logger.init();
    sp = await SharedPreferences.getInstance();
    localStorage = LocalStorage(Constants.LOCAL_STORAGE_FILE);
    await localStorage.ready;
  }

  static User getUser() {
    var userMap = localStorage.getItem(SharedPreferenceKeys.LOGIN_USER_DATA);
    return userMap != null ? User.fromJson(userMap) : null;
  }


  static clearUser() =>
      localStorage.deleteItem(SharedPreferenceKeys.LOGIN_USER_DATA);

  static putUser(User user) =>
      localStorage.setItem(SharedPreferenceKeys.LOGIN_USER_DATA, user);

  static String get token => getUser() != null ? getUser().token : null;
}