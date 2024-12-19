import 'package:loja_movil/src/domain/response/menu_response.dart';

abstract class DatabaseLocalRepository {
  Future<bool> saveMenu(List<Menu> menu);
  Future<List<Menu>> getLocalMenu();
}
