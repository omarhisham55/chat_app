import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static void showToast({
    required String msg,
    Color? color,
    ToastGravity? gravity,
    Toast? toastLength,
  }) =>
      Fluttertoast.showToast(
        msg: msg,
        backgroundColor: color,
        gravity: gravity,
        toastLength: toastLength,
      );
}
