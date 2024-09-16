import 'package:fluttertoast/fluttertoast.dart';

class ToastPopUp {
  void toast(message, bgColor, txtColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: txtColor,
      fontSize: 18.0,
    );
  }

  // void toastTwo(message, bgColor, txtColor) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: bgColor,
  //     textColor: txtColor,
  //     fontSize: 18.0,
  //   );
  // }
}
