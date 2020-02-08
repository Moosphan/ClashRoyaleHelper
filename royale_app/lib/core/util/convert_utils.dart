// Copyright 2019 Ucardstore LLC. All rights reserved.

import 'dart:convert';

class ConvertUtils {

  static String decode(String encodeCn) {
    var list = List<int>();
    jsonDecode(encodeCn).forEach(list.add);
    String value = Utf8Decoder().convert(list);
    return value;
  }

  /// 实体类转json
  static String dartToJson<T>(T obj) {
    return jsonEncode(Utf8Encoder().convert(jsonEncode(obj)));
  }

  /// json转Map
  static Map<String, dynamic> jsonToMap(String jsonString) {
    return json.decode(decode(jsonString));
  }
}