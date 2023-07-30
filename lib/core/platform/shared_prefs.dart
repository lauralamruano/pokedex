import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesManager {
  Future<bool> cleanAll();

  Future<String> getUserName();

  Future<bool> setUserName(String newValue);
}

class SharedPreferencesManagerImpl implements SharedPreferencesManager {
  final _userName = 'user_name';

  @override
  Future<bool> cleanAll() async {
    await setUserName('');
    return true;
  }

  @override
  Future<String> getUserName() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var value = sharedPrefs.getString(_userName);
    if (value == null) {
      value = '';
      await setUserName(value);
    }
    return value;
  }

  @override
  Future<bool> setUserName(String newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final res = sharedPrefs.setString(_userName, newValue);
    return res;
  }
}