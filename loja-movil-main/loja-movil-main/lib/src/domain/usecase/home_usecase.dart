import 'package:loja_movil/src/domain/repository/api_repository.dart';
import 'package:loja_movil/src/domain/repository/database_local_repository.dart';
import 'package:loja_movil/src/domain/repository/local_storage_repository.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';
import 'package:loja_movil/src/domain/response/carrusel_response.dart';
import 'package:loja_movil/src/domain/response/menu_response.dart';
import 'package:loja_movil/src/domain/response/news_response.dart';
import 'package:loja_movil/src/domain/response/user_response.dart';

class HomeUseCase {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepository apiRepositoryInterface;
  final DatabaseLocalRepository databaseLocalRepository;

  HomeUseCase({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
    required this.databaseLocalRepository,
  });

  Future<User?> getCurrentUser() async {
    return await localRepositoryInterface.getUser();
  }

  Future<CarruselResponse?> getCarrusel() async {
    return await apiRepositoryInterface.getCarrusel();
  }

  Future<List<Evento>> getFollowingActivities() async {
    return await apiRepositoryInterface.getFollowingActivities();
  }

  Future<List<News>> getNews() async {
    return await apiRepositoryInterface.getNews();
  }

  Future<List<Menu>> getMenu() async {
    return await apiRepositoryInterface.getMenu();
  }

  Future<List<Menu>> getLocalMenu() async {
    return await databaseLocalRepository.getLocalMenu();
  }
}
