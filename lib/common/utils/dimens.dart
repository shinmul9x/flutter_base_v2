import 'dart:math';

import 'package:get/get.dart';

class Dimens {
  // iphoneX screen size
  static const _default_screen_width = 375.0;
  static const _default_screen_height = 812.0;

  static double? _r;

  static double get ratio {
    if (_r == null) {
      double ratioWidth = Get.width / _default_screen_width;
      double ratioHeight = Get.height / _default_screen_height;
      var ratio = max(ratioWidth, ratioHeight);
      _r = min(1, ratio);
    }

    return _r!;
  }

  static double dimen(double value) => value * ratio;
}

extension DimensionX on num {
  double get dp => Dimens.dimen(this.toDouble());
}
