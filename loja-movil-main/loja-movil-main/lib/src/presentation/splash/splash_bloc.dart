import 'package:flutter/foundation.dart';
import 'package:loja_movil/src/domain/response/menu_response.dart';
import 'package:loja_movil/src/domain/usecase/splash_usecase.dart';

class SplashBLoC extends ChangeNotifier {
  final SplashUseCase useCase;

  SplashBLoC({
    required this.useCase,
  });

  init() async {
    List<Menu> menu = await useCase.getMenu();
    await useCase.saveMenu(menu);
  }

  /* 
  void validateTheme() async {
    final isDark = await localRepositoryInterface.isDarkMode();
    if (isDark != null) {
      Get.changeTheme(isDark ? darkTheme : lightTheme);
    } else {
      Get.changeTheme(Get.isDarkMode ? darkTheme : lightTheme);
    }
  } */

  /*Future<bool> validateSession() async {
    final token = await useCase.getToken();
    if (token != null) {
      // final user = await apiRepositoryInterface.getUserFromToken(token);
      // await localRepositoryInterface.saveUser(user);
      return true;
    } else {
      return false;
    }
  }*/
}
