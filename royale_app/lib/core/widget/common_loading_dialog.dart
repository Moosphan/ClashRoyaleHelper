// Copyright 2019 Ucardstore LLC. All rights reserved.

import 'package:flutter/material.dart';
import 'package:royale_app/core/resource/style.dart';
/// 基础的加载弹窗
class CommonLoadingDialog extends Dialog {

  final double width;
  final double height;
  final Color backgroundColor;
  final Color color;
  final String tip;

  CommonLoadingDialog({
    this.width = 120,
    this.height = 106,
    this.color = AppTheme.primaryColor,
    this.backgroundColor,
    this.tip = '马上就好..'
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: new Container(
            decoration: ShapeDecoration(
              color: backgroundColor??Colors.white,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(color),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 12),
                  child: new Text(tip, style: AppTheme.body2.copyWith(color: AppTheme.textSecondaryColor.withOpacity(0.8))),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}