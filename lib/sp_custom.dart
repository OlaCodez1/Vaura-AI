// lib/sp_custom.dart ✅ (renamed to snake_case)
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SP {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save value — now returns Future for await compatibility
  static Future<void> save(String key, dynamic value) async {
    await init();
    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, value);
    } else if (value is Map) {
      await _prefs!.setString(key, jsonEncode(value));
    } else {
      throw Exception('Unsupported value type');
    }
  }

  // Read value (dynamic)
  static dynamic read(String key) {
    return _prefs?.get(key);
  }

  // Get Map<String, dynamic>
  static Future<Map<String, dynamic>?> getMap(String key) async {
    await init();
    final jsonString = _prefs?.getString(key);
    if (jsonString == null) return null;
    final decoded = jsonDecode(jsonString);
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) return Map<String, dynamic>.from(decoded);
    return null;
  }

  // Alias for save
  static Future<void> edit(String key, dynamic newValue) => save(key, newValue);

  // Delete
  static Future<void> del(String key) async {
    await init();
    await _prefs!.remove(key);
  }

  // Check key existence
  static Future<bool> has(String key) async {
    await init();
    return _prefs!.containsKey(key);
  }

  // Clear all
  static Future<void> wipe() async {
    await init();
    await _prefs!.clear();
  }
}
