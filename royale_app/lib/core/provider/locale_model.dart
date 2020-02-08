// Copyright 2019 Ucardstore LLC. All rights reserved.

import 'package:flutter/material.dart';
import 'package:royale_app/core/resource/shared_preference_keys.dart';

import '../../application.dart';
/// Locale model to listen language changes.
class LocaleModel extends ChangeNotifier {
  static const localeValueList = ['', 'zh-CN', 'en'];

  int _localeIndex;

  int get localeIndex => _localeIndex;

  Locale get locale {
    if (_localeIndex > 0) {
      var value = localeValueList[_localeIndex].split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    // 跟随系统
    return null;
  }

  LocaleModel() {
    _localeIndex = Application.sp.getInt(SharedPreferenceKeys.LOCALE_INDEX_KEY) ?? 0;
  }

  // apply to current locale by index
  applyLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    Application.sp.setInt(SharedPreferenceKeys.LOCALE_INDEX_KEY, index);
  }

}