import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:loja_movil/src/utils/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:loja_movil/src/domain/usecase/home_usecase.dart';
import 'package:loja_movil/src/domain/response/menu_response.dart';
import 'package:loja_movil/src/domain/response/news_response.dart';
import 'package:loja_movil/src/domain/response/user_response.dart';
import 'package:loja_movil/src/domain/response/carrusel_response.dart';
import 'package:loja_movil/src/domain/response/activities_by_local_id_response.dart';

class HomeBLoC extends ChangeNotifier {
  final HomeUseCase useCase;

  List<ActividadesCarrusel> carrusel = [];

  User? user;

  List<Evento> followingActivities = [];
  List<News> news = [];
  List<Menu> menu = [];

  int currentPageCarrousel = 0;
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  HomeBLoC({
    required this.useCase,
  });

  init() async {
    getInitData();
  }

  getInitData() async {
    try {
      followingActivities = await useCase.getFollowingActivities();
      news = await useCase.getNews();
      news.insert(0,
          firstNewBanner); // Se agrega un primer banner de una imagen turistica al slider de noticias
      menu = await useCase.getLocalMenu();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  setCurrentPageCarrousel(int page) {
    currentPageCarrousel = page;
    notifyListeners();
  }

  openNews(url) async {
    final Uri url0 = Uri.parse(url);
    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }
}
