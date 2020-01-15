import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextStyle titleStyle() {
  return const TextStyle(
//    fontFamily: 'BookAntiqua',
//    fontFamilyFallback: ['AppFont'],
//    fontSize: 24,
//    fontWeight: FontWeight.bold
      );
}

TextStyle smallTitleStyle() {
  return const TextStyle(
//      fontFamily: 'BookAntiqua',
//      fontFamilyFallback: ['AppFont'],
//      fontSize: 18,
//      fontWeight: FontWeight.bold
      );
}

showLoading(context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingDialog(text: '加载中');
      });
}

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: 1,
  );
}
