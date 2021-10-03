import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
 static saveData(int id) async {
    final prefs = await SharedPreferences.getInstance();

// set value
    prefs.setInt('id', id);
  }
  static Future<int> readData() async {
    final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
    final counter = prefs.getInt('id') ?? 0;
    return counter;
  }
}