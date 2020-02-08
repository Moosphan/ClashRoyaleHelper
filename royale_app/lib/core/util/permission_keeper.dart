// Copyright 2019 Ucardstore LLC. All rights reserved.

import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'log_utils.dart';

class PermissionKeeper {
  PermissionKeeper._();

  static Future<bool> requestLocationPermission() async {
    final permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
    Logger.e('获取的权限为：$permissions');

    if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
      return true;
    } else {
      Fluttertoast.showToast(msg: '缺少定位权限');
      return false;
    }
  }

  static Future<bool> requestStoragePermission() async {
    final permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    Logger.e('获取的权限为：$permissions');

    if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
      return true;
    } else {
      Fluttertoast.showToast(msg: '缺少存储权限');
      return false;
    }
  }

}