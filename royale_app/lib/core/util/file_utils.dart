// Copyright 2019 Ucardstore LLC. All rights reserved.
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

/// 文件相关工具类
/// @author Moosphon
class FileUtils {
  FileUtils._();

  /// 判断文件是否存在
  static Future<bool> isFileExist(String path) async {
    var fontFile = File(path);
    return await fontFile.exists();
  }

  /// 将文件转为[Uint8List]
  // https://stackoverflow.com/questions/56044473/how-to-get-bytedata-from-a-file
  static Future<Uint8List> convertFileToUnit8List(String path) async {
    File file = File(path);
    Uint8List bytes = await file.readAsBytes();
    return bytes;
  }

  /// 将资源文件转为[Uint8List]
  static Future<Uint8List> convertAssetToUnit8List(String assetImage) async {
    ByteData byteData = await rootBundle.load(assetImage);
    return byteData.buffer.asUint8List();
  }

  /// 将本地文件转为[ByteData]格式 (字体使用)
  /// https://stackoverflow.com/questions/56044473/how-to-get-bytedata-from-a-file
  static Future<ByteData> getFileAsByteData(String path) async {
    File file = File(path);
    Uint8List bytes = await file.readAsBytes();
    return ByteData.view(bytes.buffer);
  }

  /// 获取字体文件的后缀 e.g. -> .ttf | .otf
  static String getFontFormat(String url) => url.substring(url.length - 4, url.length);
}
