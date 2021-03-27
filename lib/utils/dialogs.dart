import 'package:flutter/material.dart';
import 'package:shop_like_app_rest/widgets/custom_dialog.dart';

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context) async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog.loading();
      },
    );
  }

  static Future<void> showErrorDialog(BuildContext context, String error) async{
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

  static Future<bool> showConfirmDeleteAdvertDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog.confirmAdvertDelete();
      },
    );
  }

  static Future<bool> showConfirmDeleteUserDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog.confirmUserDelete();
      },
    );
  }
}
