import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final _preferences = SharedPreferences.getInstance();

  Future<T> get<T>(String key, T defaultValue) async {
    final instance = await _preferences;
    final result = instance.get(key);

    return result is T ? result : defaultValue;
  }

  Future<void> set(String key, Object value) async {
    final instance = await _preferences;

    if (value is bool) {
      await instance.setBool(key, value);
    } else if (value is int) {
      await instance.setInt(key, value);
    } else if (value is double) {
      await instance.setDouble(key, value);
    } else if (value is String) {
      await instance.setString(key, value);
    } else if (value is List<String>) {
      await instance.setStringList(key, value);
    } else {
      throw Exception("Does't support type ${value.runtimeType} yet.");
    }
  }
}
