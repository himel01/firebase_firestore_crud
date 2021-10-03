import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
 static saveData(int id) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('id', id);
  }
  static Future<int> readData() async {
    final prefs = await SharedPreferences.getInstance();

    final counter = prefs.getInt('id') ?? 0;
    return counter;
  }
}