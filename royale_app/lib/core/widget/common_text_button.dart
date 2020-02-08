// Copyright 2019 Ucardstore LLC. All rights reserved.
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
/// 通用的文字按钮

class CommonTextButton extends StatelessWidget {

  final VoidCallback callback;
  final String text;
  final TextStyle style;

  CommonTextButton({this.text, this.style, this.callback});

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      text: text,
      style: style,
      recognizer: new TapGestureRecognizer()
        ..onTap = callback
    ));
  }
}
