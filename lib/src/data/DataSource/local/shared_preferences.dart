import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<dynamic> read(String key) async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getString(key) != null) {
      return json.decode(pref.getString(key)!);
    }
    return null;
  }

  Future<bool> remove(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }

  Future<bool> contain(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey(key);
  }
}
