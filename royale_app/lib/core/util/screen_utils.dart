// Copyright 2019 Ucardstore LLC. All rights reserved.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royale_app/core/resource/style.dart';
/// 用于处理界面排版的工具类
class ScreenUtils {
  ScreenUtils._();

  static verticalSpace(double size) => SizedBox(
    height: size,
  );

  static horizontalSpace(double size) => SizedBox(
    width: size,
  );

  static divider(double space) => Divider(
    height: AppTheme.underlineBorderWidth,
    indent: space,
    endIndent: space,
    color: AppTheme.borderColor,
  );
}