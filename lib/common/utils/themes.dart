import 'package:flutter/material.dart';
import '../common.dart';

class AppTextTheme {
  static const _kColor = Colors.black;
  static const _kTextHeight = 1.25;

  static TextStyle _textStyle(
    double fontSize,
    FontWeight fontWeight,
    double? height,
    Color? color, [
    TextDecoration decoration = TextDecoration.none,
  ]) {
    return TextStyle(
      color: color ?? _kColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
      decoration: decoration,
      height: height ?? _kTextHeight,
    );
  }

  static TextStyle regular(double fontSize, double? height, [Color? color]) {
    return _textStyle(fontSize, FontWeight.normal, height, color);
  }

  static TextStyle bold(double fontSize, double? height, [Color? color]) {
    return _textStyle(fontSize, FontWeight.bold, height, color);
  }

  static TextStyle t16W700([Color? color]) {
    return _textStyle(16.dp, FontWeight.w700, null, color);
  }
}
