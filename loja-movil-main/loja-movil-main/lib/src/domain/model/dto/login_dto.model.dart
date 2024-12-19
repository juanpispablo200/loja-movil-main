import 'package:loja_movil/src/domain/response/user_response.dart';

class LoginDTO {
  bool ok;
  String? accessToken;
  int? expiresIn;
  int? refreshExpiresIn;
  String? refreshToken;
  User? user;

  LoginDTO({
    this.ok = false,
    this.accessToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.refreshToken,
    this.user,
  });
}
