import 'package:fluttertoast/fluttertoast.dart';

class AppAlerts {
  AppAlerts._();

  static void showErrorMessage(String text) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
    );
  }
}
