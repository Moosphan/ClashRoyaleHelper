// Copyright 2019 Ucardstore LLC. All rights reserved.
import 'package:flutter/material.dart';

/// 通用加载UI小组件
class CommonProgressIndicator extends StatelessWidget {

  final double size;
  final Color color;
  final double strokeWidth;

  CommonProgressIndicator({
    this.size: 24,
    this.color: Colors.white,
    this.strokeWidth: 2
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }

}