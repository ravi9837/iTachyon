import 'package:fluttertoast/fluttertoast.dart';
import 'package:itachyon/const/appColor.dart';

///SHOWS A TOAST MESSAGE
showToast(String message, ToastGravity gravity) {
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: AppColor.blue,
    gravity: gravity,
    textColor: AppColor.white,
    fontSize: 15,
    toastLength: Toast.LENGTH_SHORT,
  );
}