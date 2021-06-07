import 'package:base/library.dart';

class DialogHelper {
  static showDialog(String? message, {required VoidCallback onOk}) async {
    return Get.dialog(ConfirmDialog(
      message ?? 'this is confirm dialog.',
      onOk: onOk,
    ));
  }
}
