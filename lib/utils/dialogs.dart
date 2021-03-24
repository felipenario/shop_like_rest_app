import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/widgets/custom_dialog.dart';

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog.loading();
      },
    );
  }

  static Future<void> showErrorDialog(BuildContext context, String error) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog.error(content: error);
      },
    );
  }

  static Future<void> showSuccessDialog(BuildContext context, String msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog.success(content: msg);
      },
    );
  }
}
