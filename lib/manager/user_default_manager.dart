import 'package:shared_preferences/shared_preferences.dart';

class UserDefaultManager {
  static final UserDefaultManager _shared = UserDefaultManager._internal();

  factory UserDefaultManager.shared() {
    return _shared;
  }

  UserDefaultManager._internal();

  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  Future<void> setValue(UserKeys key, dynamic value) async {
    if (value == null) {
      return;
    }
    final SharedPreferences prefs = await _prefs;

    if (value is int) {
      await prefs.setInt(key.value, value);
    } else if (value is bool) {
      await prefs.setBool(key.value, value);
    } else if (value is double) {
      await prefs.setDouble(key.value, value);
    } else if (value is String) {
      await prefs.setString(key.value, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key.value, value);
    } else {
      throw Exception('Invalid data type');
    }
  }

  Future<dynamic> getValue(UserKeys key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(key.value);
  }

  Future<void> removeValue(UserKeys key) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(key.value);
  }
}

enum UserKeys { token, firstName, lastName, avatar, isVerifyId }

extension UserKeysExtension on UserKeys {
  String get value {
    switch (this) {
      case UserKeys.token:
        return "token";
      case UserKeys.firstName:
        return "firstName";
      case UserKeys.lastName:
        return "lastName";
      case UserKeys.avatar:
        return "avatar";
      case UserKeys.isVerifyId:
        return "isVerifyId";
      default:
        return "Unknown";
    }
  }
}
