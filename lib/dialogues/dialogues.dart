import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dialogues {
  static void showSnackBar(BuildContext context, String msg,Color color_notification){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration:Duration(seconds: 1),content: Text(msg),backgroundColor: color_notification.withOpacity(.8),
      behavior: SnackBarBehavior.floating,));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context:context,
        builder: (_)=>const Center(child: CircularProgressIndicator())
    );
  }
  static void showToast(BuildContext context,String message) {
    Fluttertoast.showToast(
        backgroundColor: Colors.blueGrey.shade400,
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 13.0
    );
  }
}
