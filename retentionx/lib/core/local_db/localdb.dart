import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;

  LocalDatabase._internal();

  Future<void> saveData(String key, Map<String, dynamic> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(value);
    await prefs.setString(key, jsonString);
    print("saved successfully");
  }

  Future<Map<String, dynamic>?> getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  Future<void> updateData(String key, Map<String, dynamic> newValue) async {
    await saveData(key, newValue);
  }

  Future<void> deleteData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
