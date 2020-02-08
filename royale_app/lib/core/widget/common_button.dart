// Copyright 2019 Ucardstore LLC. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:royale_app/core/resource/style.dart';

/// 通用的主题色按钮
class CommonButton extends StatelessWidget {

  final Widget child;
  final VoidCallback callback;
  final double cornerRadius;

  CommonButton({this.child, this.callback, this.cornerRadius});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      color: AppTheme.primaryColor,
      borderRadius: BorderRadius.circular(cornerRadius),
      disabledColor: AppTheme.primaryColor.withAlpha(160),
      pressedOpacity: 0.6,
      child: child,
      onPressed: callback,
    );
  }

}