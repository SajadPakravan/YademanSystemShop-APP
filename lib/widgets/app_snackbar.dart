import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yad_sys/themes/app_themes.dart';

class AppSnackBar {
  error({required BuildContext context, required String message}) {
    double width = MediaQuery.of(context).size.width;
    return Flushbar(
      textDirection: TextDirection.rtl,
      margin: EdgeInsets.all(width * 0.03),
      padding: EdgeInsets.all(width * 0.02),
      backgroundColor: Colors.redAccent,
      borderRadius: BorderRadius.circular(width),
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_rounded,
            color: Colors.white,
          ),
          AutoSizeText(
            message,
            style: Theme.of(context).textTheme.errorText1,
            textAlign: TextAlign.center,
            minFontSize: 12,
            maxLines: 3,
            maxFontSize: 12,
          ),
        ],
      ),
      isDismissible: false,
      duration: const Duration(seconds: 5),
    )..show(context);
  }
}
