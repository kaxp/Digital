import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesManager = SharedPreferencesManager();

class SharedPreferencesManager {
  static late SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setStringList(String key, List<String>? value) async {
    if (value != null) {
      return _prefs.setStringList(key, value);
    }
    return false;
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  Future<bool> clearData(String key) {
    return _prefs.remove(key);
  }
}

class SharedPreferencesKeys {
  static const String favouriteEvents = 'favourite_events';
}
