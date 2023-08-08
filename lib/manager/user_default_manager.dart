import 'package:shared_preferences/shared_preferences.dart';

class UserDefaultManager {
  static final UserDefaultManager _shared = UserDefaultManager();
  factory UserDefaultManager.shared() {
    return _shared;
  }

  UserDefaultManager();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setValue(String key, dynamic value) async {
    SharedPreferences prefs = await _prefs;

    switch (value.runtimeType) {
      case int:
        await prefs.setInt(key, value);
        break;
      case bool:
        await prefs.setBool(key, value);
        break;
      case double:
        await prefs.setDouble(key, value);
        break;
      case String:
        await prefs.setString(key, value);
        break;
      case [String]:
        await prefs.setStringList(key, value);
        break;
      default:
        throw Exception('Invalid data type');
    }
  }

  Future<T?> getValue<T>(String key) async {
    SharedPreferences prefs = await _prefs;

    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
      case bool:
        return prefs.getBool(key) as T?;
      case double:
        return prefs.getDouble(key) as T?;
      case String:
        return prefs.getString(key) as T?;
      case [String]:
        return prefs.getStringList(key) as T?;
      default:
        return null;
    }
  }

  Future<void> removeValue(String key) async {
    SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }
}
