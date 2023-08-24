import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(String message, BuildContext context,
      {Color? color}) {
    Flushbar(
      backgroundColor: color??Colors.amber,
      borderRadius: BorderRadius.circular(20),
      animationDuration:  const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      message: message,
      margin: const EdgeInsets.symmetric(vertical: 20),
    ).show(context);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     margin: const EdgeInsets.all(20),
    //     shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(20))),
    //     behavior: SnackBarBehavior.floating,
    //     backgroundColor: color,
    //     duration: const Duration(seconds: 3),
    //     content: Text(message),
    //   ),
    // );
  }
}
