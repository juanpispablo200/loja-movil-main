import 'package:loja_movil/src/data/datasource/database_helper.dart';
import 'package:loja_movil/src/domain/repository/database_local_repository.dart';
import 'package:loja_movil/src/domain/response/menu_response.dart';

class DatabaseLocalRepositoryImpl extends DatabaseLocalRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<bool> saveMenu(List<Menu> menu) async {
    try {
      int countTable = await dbHelper.queryRowCount();

      if (menu.isNotEmpty && countTable > 0) {
        await dbHelper.deleteAll();
      }

      for (var i = 0; i < menu.length; i++) {
        Menu men = menu[i];

        final Map<String, dynamic> row = {
          'id': men.id,
          'titulo': men.titulo,
          'ruta': men.ruta,
          'icono': men.icono,
          'backgroundColor': men.backgroundColor,
          'prioridad': men.prioridad,
        };
        await dbHelper.insert(row);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Menu>> getLocalMenu() async {
    var maps = await dbHelper.queryAllRows();
    List<Menu> list = [];
    for (var i = 0; i < maps.length; i++) {
      final m = maps[i];
      final menu = Menu.fromJson(m);
      list = [...list, menu];
    }
    return list;
  }
}
