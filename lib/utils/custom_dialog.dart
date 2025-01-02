import 'package:flutter/material.dart';

//! Custom SnackBar
void customSnackBar(BuildContext context, String message,
    {Color? color, int? seconds}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: seconds ?? 3),
      backgroundColor: color ?? Colors.red,
      content: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

//! Custom Dialog
class CustomDialogHandler {
  static bool _isDialogShowing = false;

  static Future<void> showCustomDialog(
    BuildContext context,
    String errorMessage, {
    TextEditingController? controller,
    Color? backgroundColor,
    double height = 100,
    void Function()? agreeTap,
    void Function()? cancelTap,
    String? agreeName,
    String? cancelName,
    TextStyle? textStyle,
    TextStyle? buttontextStyle,
    bool enableCancelButton = false,
  }) async {
    // تحقق مما إذا كان الحوار معروضًا بالفعل
    if (_isDialogShowing) return;

    _isDialogShowing = true;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          content: Container(
            height: height,
            padding: const EdgeInsets.all(10),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: agreeTap,
                  child: Text(
                    agreeName ?? "Ok",
                    style: buttontextStyle,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                enableCancelButton
                    ? TextButton(
                        onPressed: cancelTap,
                        child: Text(
                          cancelName ?? "Cancel",
                          style: buttontextStyle,
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        );
      },
    );

    // عند إغلاق الحوار، إعادة تعيين الحالة
    _isDialogShowing = false;
  }
}
