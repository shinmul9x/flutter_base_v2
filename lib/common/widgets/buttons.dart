import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:base/library.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.child,
    this.gradient,
    this.onPressed,
    this.buttonColor,
    this.enabled = true,
    this.borderRadius,
    this.minimumSize,
    this.padding,
  }) : super(key: key);

  factory CustomButton.icon({
    required Widget label,
    required Widget icon,
    Gradient? gradient,
    Size? minimumSize,
    Function()? onPressed,
    Color? buttonColor,
    bool enabled,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
  }) = _CustomButtoWithIcon;

  final Widget child;
  final Gradient? gradient;
  final Size? minimumSize;
  final Function()? onPressed;
  final Color? buttonColor;
  final bool enabled;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    var minimumSize = this.minimumSize ?? Size(64.dp, 36.dp);
    var borderRadius = this.borderRadius ?? BorderRadius.circular(4);
    var padding = this.padding ?? defaultPadding(context);
    var onPressed = this.onPressed ?? () {};

    var result = Ink(
      decoration: BoxDecoration(
        gradient: enabled ? gradient : null,
        color: buttonColor,
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: _InputPadding(
        minSize: minimumSize,
        child: child,
      ),
    );

    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      child: result,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  defaultPadding(BuildContext context) {
    return ButtonStyleButton.scaledPadding(
      const EdgeInsets.symmetric(horizontal: 16),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
  }
}

class _CustomButtoWithIcon extends CustomButton {
  _CustomButtoWithIcon({
    required Widget label,
    required Widget icon,
    Gradient? gradient,
    Size? minimumSize,
    Function()? onPressed,
    Color? buttonColor,
    bool enabled = true,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
  }) : super(
          child: _CustomButtoWithIconChild(icon, label),
          gradient: gradient,
          minimumSize: minimumSize,
          onPressed: onPressed,
          buttonColor: buttonColor,
          enabled: enabled,
          borderRadius: borderRadius,
          padding: padding,
        );
}

class _CustomButtoWithIconChild extends StatelessWidget {
  final Widget label;
  final Widget icon;

  const _CustomButtoWithIconChild(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), label],
    );
  }
}

class _InputPadding extends SingleChildRenderObjectWidget {
  const _InputPadding({
    Key? key,
    Widget? child,
    required this.minSize,
  }) : super(key: key, child: child);

  final Size minSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderInputPadding(minSize);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderInputPadding renderObject) {
    renderObject.minSize = minSize;
  }
}

class _RenderInputPadding extends RenderShiftedBox {
  _RenderInputPadding(this._minSize, [RenderBox? child]) : super(child);

  Size get minSize => _minSize;
  Size _minSize;
  set minSize(Size value) {
    if (_minSize == value) return;
    _minSize = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child != null)
      return math.max(child!.getMinIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null)
      return math.max(child!.getMinIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null)
      return math.max(child!.getMaxIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null)
      return math.max(child!.getMaxIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  Size _computeSize(
      {required BoxConstraints constraints,
      required ChildLayouter layoutChild}) {
    if (child != null) {
      final Size childSize = layoutChild(child!, constraints);
      final double height = math.max(childSize.width, minSize.width);
      final double width = math.max(childSize.height, minSize.height);
      return constraints.constrain(Size(height, width));
    }
    return Size.zero;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
    );
  }

  @override
  void performLayout() {
    size = _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
    );
    if (child != null) {
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset =
          Alignment.center.alongOffset(size - child!.size as Offset);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (super.hitTest(result, position: position)) {
      return true;
    }
    final Offset center = child!.size.center(Offset.zero);
    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(center),
      position: center,
      hitTest: (BoxHitTestResult result, Offset? position) {
        assert(position == center);
        return child!.hitTest(result, position: center);
      },
    );
  }
}
