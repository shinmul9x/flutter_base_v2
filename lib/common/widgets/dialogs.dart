import 'package:base/library.dart';

abstract class DialogBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var child = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: Align(
        child: buildContent(context),
        alignment: Alignment.topCenter,
        heightFactor: 1,
      ),
    );

    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: dialogAlignment,
        margin: margin,
        child: Stack(
          alignment: Alignment.topRight,
          children: [child, if (cancelable) cancelButton],
        ),
      ),
    );
  }

  Widget get cancelButton {
    return IconButton(
      icon: Icon(Icons.close),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: Get.back,
    );
  }

  BorderRadiusGeometry? get borderRadius => BorderRadius.circular(8);

  Widget buildContent(BuildContext context);

  bool get cancelable;

  EdgeInsetsGeometry get margin => EdgeInsets.all(24.dp);

  AlignmentGeometry get dialogAlignment;

  EdgeInsetsGeometry? get padding;
}

class ConfirmDialog extends DialogBase {
  final String message;
  final VoidCallback? onOk;

  ConfirmDialog(this.message, {this.onOk});

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('hello world'),
        SizedBox(height: 24),
        CustomButton(
          child: Text('Ok'),
          onPressed: onOk,
        ),
      ],
    );
  }

  @override
  bool get cancelable => true;
  @override
  AlignmentGeometry get dialogAlignment => Alignment.center;
  @override
  EdgeInsetsGeometry? get padding {
    return const EdgeInsets.only(
      top: 48,
      bottom: 16,
    );
  }
}
