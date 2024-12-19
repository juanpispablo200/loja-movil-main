import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:loja_movil/src/domain/model/locality.dart';
import 'package:loja_movil/src/domain/request/id_request.dart';
import 'package:loja_movil/src/domain/response/locality_response.dart';
import 'package:loja_movil/src/domain/usecase/tourism_usecase.dart';

class LocalityRouteDetailBLoC extends ChangeNotifier {
  final TourismUseCase useCase;
  LocalityRouteDetailBLoC({required this.useCase});

  int currentPageCarrousel = 0;
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  // Locality
  bool loadingLocality = false;
  Locality? locality;

  init(int localityId) async {
    await getLocalityById(localityId);
  }

  setCurrentPageCarrousel(int page) {
    currentPageCarrousel = page;
    notifyListeners();
  }

  Future<void> getLocalityById(int localityId) async {
    IdRequest request = IdRequest();
    request.id = localityId;

    try {
      loadingLocality = true;
      notifyListeners();
      LocalityResponse routeRep = await useCase.getLocalityById(request);
      locality = routeRep.fullLocality;
    } catch (e) {
      debugPrint('Error obteniendo la ruta: $e');
    } finally {
      loadingLocality = false;
      notifyListeners();
    }
  }
}
