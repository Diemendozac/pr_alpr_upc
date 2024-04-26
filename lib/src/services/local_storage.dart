
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('baseUrl', 'http://ec2-15-229-70-105.sa-east-1.compute.amazonaws.com:8080');
  }

}