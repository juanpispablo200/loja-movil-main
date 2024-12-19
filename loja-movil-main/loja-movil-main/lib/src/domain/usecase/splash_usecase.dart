import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/repository/database_local_repository.dart';
import 'package:loja_movil/src/domain/repository/local_storage_repository.dart';
import 'package:loja_movil/src/domain/response/menu_response.dart';

class SplashUseCase {
  final DatabaseLocalRepository repository;
  final ApiRepository apiRepository;
  final LocalRepositoryInterface localRepositoryInterface;

  SplashUseCase({
    required this.apiRepository,
    required this.repository,
    required this.localRepositoryInterface,
  });

  Future<List<Menu>> getMenu() async {
    return await apiRepository.getMenu();
  }

  Future<bool> saveMenu(List<Menu> menu) async {
    return await repository.saveMenu(menu);
  }

  Future<String?> getToken() async {
    return localRepositoryInterface.getToken();
  }
}
