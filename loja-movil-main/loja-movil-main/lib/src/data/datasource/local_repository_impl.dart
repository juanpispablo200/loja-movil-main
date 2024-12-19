// ignore_for_file: constant_identifier_names

import 'package:loja_movil/src/domain/repository/local_storage_repository.dart';
import 'package:loja_movil/src/domain/response/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _pref_token = 'TOKEN';
const _pref_refresh_token = 'REFRESH-TOKEN';
const _pref_user = 'USER';
const _pref_dark_theme = 'THEME_DARK';

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.clear();
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_pref_token);
  }

  @override
  Future<String> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(_pref_token, token);

    return token;
  }

  @override
  Future<User?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final user = sharedPreferences.getString(_pref_user);
    if (user == null) {
      return null;
    }
    return userFromJson(user);
  }

  @override
  Future<User> saveUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var userStr = userToJson(user);
    sharedPreferences.setString(_pref_user, userStr);

    return user;
  }

  @override
  Future<bool> isDarkMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isDark = sharedPreferences.getBool(_pref_dark_theme);

    if (isDark == null) {
      return false;
    } else {
      return isDark;
    }
  }

  @override
  Future<void> saveDarkMode(bool darkMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_pref_dark_theme, darkMode);
  }

  @override
  Future<String?> getRefreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_pref_refresh_token);
  }

  @override
  Future<String?> saveRefreshToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_pref_refresh_token, token);
    return token;
  }
}
