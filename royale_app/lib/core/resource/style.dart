// Copyright 2020 Moosphon. All rights reserved.
/**
 * 定义全局主题配置信息
 * includes: textStyle and colors
 */
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  /// common colors used in theme, text, background or borders
  static const Color primaryColor = Color(0xFF363330);
  static const Color secondaryColor = Color(0x9670CACE);
  static const Color accentColor = Color(0xFFFEAA9A);

  static const Color textPrimaryColor = Color(0xFF2A2A2A);
  static const Color textSecondaryColor = Color(0xFF383838);
  static const Color textHintColor = Color(0xFFB3B3B3);
  static const Color borderColor = Color(0xFFE6E6E7);
  static const Color surfaceColor = Color(0xFFEEEEF2);
  static const Color avatarBorderColor = Color(0xFF121212);
  static const Color messageOvalColor = Color(0xFFFF7979);
  static const Color chipColor = Color(0xFFBDC1CB);

  static const double underlineBorderWidth = 0.8;


  /// styles for different types of text

  /// The Material Design typography scheme was significantly changed in the
  /// current (2018) version of the specification
  /// (https://material.io/design/typography).
  ///
  /// The 2018 spec has thirteen text styles:
  /// ```
  /// NAME         SIZE  WEIGHT  SPACING
  /// headline1    96.0  light   -1.5
  /// headline2    60.0  light   -0.5
  /// headline3    48.0  normal   0.0
  /// headline4    34.0  normal   0.25
  /// headline5    24.0  normal   0.0
  /// headline6    20.0  medium   0.15
  /// subtitle1    16.0  normal   0.15
  /// subtitle2    14.0  medium   0.1
  /// body1        16.0  normal   0.5
  /// body2        14.0  normal   0.25
  /// button       14.0  medium   0.75
  /// caption      12.0  normal   0.4
  /// overline     10.0  normal   1.5

  static TextTheme textTheme = TextTheme(
    headline: headline,
    title: title,
    body1: body1,
    body2: body2,
    caption: small,
    overline: micro
  );

  // large title
  static const headline = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
    letterSpacing: 0.27,
    color: textPrimaryColor
  );

  // normal title
  static const title = TextStyle(
    fontSize: 18,
    letterSpacing: 0.18,
    color: textPrimaryColor
  );

  // normal text body1
  static TextStyle body1 = TextStyle(
    fontSize: 16,
    letterSpacing: 0.48,
    color: textPrimaryColor
    /// handle the cursor offset problem because of chinese locale.
  ).copyWith(textBaseline: TextBaseline.alphabetic);

  // normal text body2
  static TextStyle body2 = TextStyle(
    fontSize: 14,
    letterSpacing: 0.25,
    color: textSecondaryColor
    /// handle the cursor offset problem because of chinese locale.
  ).copyWith(textBaseline: TextBaseline.alphabetic);

  static TextStyle smallDark = TextStyle(
      fontSize: 12,
      color: textSecondaryColor
    /// handle the cursor offset problem because of chinese locale.
  ).copyWith(textBaseline: TextBaseline.alphabetic);

  static TextStyle small = TextStyle(
    fontSize: 12,
    color: textHintColor
    /// handle the cursor offset problem because of chinese locale.
  ).copyWith(textBaseline: TextBaseline.alphabetic);

  // micro text
  static const micro = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: textHintColor
  );

  // input field border decoration style
  static const inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(fontSize: 14),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: underlineBorderWidth, color: primaryColor)
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(width: underlineBorderWidth, color: borderColor)
    ),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: underlineBorderWidth, color: borderColor)
    ),
    disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: underlineBorderWidth, color: borderColor)
    ),
  );

  // appBar theme
  static AppBarTheme appBarTheme = AppBarTheme(
    textTheme: textTheme,
    // 状态栏文字主题(此处为黑色)
    brightness: Brightness.light
  );



}