import 'package:shared_preferences/shared_preferences.dart';

class UserDefaultManager {
  static final UserDefaultManager _shared = UserDefaultManager();
  factory UserDefaultManager.shared() {
    return _shared;
  }
  UserDefaultManager() {
    setPrefs();
  }
  SharedPreferences? prefs;

  Future<void> setPrefs() async {
    await SharedPreferences.getInstance();
  }

  void setValue(String key, dynamic value) async {
    switch (value.runtimeType) {
      case int:
        await prefs?.setInt(key, value as int);
        break;
      case bool:
        await prefs?.setBool(key, value as bool);
        break;
      case double:
        await prefs?.setDouble(key, value as double);
        break;
      case String:
        await prefs?.setString(key, value as String);
        break;
      case <String>[]:
        await prefs?.setStringList(key, value as List<String>);
        break;
    }
  }

  T? getValue<T>(String key) {
    switch (T.runtimeType) {
      case int:
        return prefs?.getInt(key) as T;
      case bool:
        return prefs?.getBool(key) as T;
      case double:
        return prefs?.getDouble(key) as T;
      case String:
        return prefs?.getString(key) as T;
      case <String>[]:
        return prefs?.getStringList(key) as T;
    }
  }
}
