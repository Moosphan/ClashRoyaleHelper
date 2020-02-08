// Copyright 2019 Ucardstore LLC. All rights reserved.

/// 日志打印工具类
class Logger {
  static const String _DEFAULT_TAG = "<††† Timeory †††>";
  static bool debuggable = false;
  static String globalTag = '';

  static void init({bool isDebug = false, String tag = _DEFAULT_TAG}) {
    debuggable = isDebug;
    globalTag = tag;
  }

  static void e(Object info, {String tag}) {
    _printLog(tag, ' : ', info);
  }

  // 如果当前不为debug模式，则不输出日志
  static void d(Object info, {String tag}) {
    if (debuggable) {
      _printLog(tag, ' : ', info);
    }
  }

  static void _printLog(String tag, String separator, Object object) {
    String da = object.toString();
    String _tag = (tag == null || tag.isEmpty) ? globalTag : tag;
    while (da.isNotEmpty) {
      if (da.length > 2048) {
        print("$_tag $separator ${da.substring(0, 2048)}");
        da = da.substring(2048, da.length);
      } else {
        print("$_tag $separator $da");
        da = "";
      }
    }
  }
}