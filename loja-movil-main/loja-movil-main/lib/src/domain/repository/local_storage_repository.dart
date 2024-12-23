import 'package:loja_movil/src/domain/response/user_response.dart';

abstract class LocalRepositoryInterface {
  Future<String?> getToken();
  Future<String> saveToken(String token);
  Future<String?> getRefreshToken();
  Future<String?> saveRefreshToken(String token);
  Future<void> clearAllData();
  Future<User> saveUser(User user);
  Future<User?> getUser();
  Future<void> saveDarkMode(bool darkMode);
  Future<bool> isDarkMode();
}
