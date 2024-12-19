import 'package:loja_movil/src/domain/model/dto/login_dto.model.dart';
import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/repository/local_storage_repository.dart';

class LoginUseCase {
  final ApiRepository apiRepository;
  final LocalRepositoryInterface localRepositoryInterface;

  LoginUseCase({
    required this.apiRepository,
    required this.localRepositoryInterface,
  });

  Future<LoginDTO> login(String username, String password) async {
    var loginDTO = LoginDTO();

    var respLogin = await apiRepository.login(username, password);

    if (respLogin != null) {
      var user = await apiRepository.getUser(respLogin.accessToken);
      if (user != null) {
        // guardar info en storage
        localRepositoryInterface.saveToken(respLogin.accessToken);
        localRepositoryInterface.saveRefreshToken(respLogin.refreshToken);
        localRepositoryInterface.saveUser(user);

        loginDTO.accessToken = respLogin.accessToken;
        loginDTO.expiresIn = respLogin.expiresIn;
        loginDTO.refreshExpiresIn = respLogin.refreshExpiresIn;
        loginDTO.refreshToken = respLogin.refreshToken;
        loginDTO.user = user;
        loginDTO.ok = true;
      } else {
        loginDTO.ok = false;
      }
    } else {
      loginDTO.ok = false;
    }

    return loginDTO;
  }
}
