import 'package:shared_preferences/shared_preferences.dart';

class Db {
  static late SharedPreferences p;
  static Future<void> init() async {
    p = await SharedPreferences.getInstance();
  }

  static const String list = "list";
}
