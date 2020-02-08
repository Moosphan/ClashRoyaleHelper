// Copyright 2019 Ucardstore LLC. All rights reserved.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'common_button.dart';

/// 通用的顶部导航栏小组件
class DefaultActionButton extends StatelessWidget {

  final String actionText;
  final VoidCallback callback;

  DefaultActionButton({this.actionText, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 18, top: 14, bottom: 14),
      child: CommonButton(
        cornerRadius: 6,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        callback: callback,
      ),
    );
  }
}

