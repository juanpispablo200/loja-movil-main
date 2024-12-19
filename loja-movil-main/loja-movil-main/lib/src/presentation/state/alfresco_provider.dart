import 'package:flutter/material.dart';
import 'package:loja_movil/src/domain/usecase/alfresco_usecase.dart';

class AlfrescoProvider with ChangeNotifier {
  final AlfrescoUseCase useCase;

  AlfrescoProvider({
    required this.useCase,
  });

  init() async {}

  getImage() async {
    var resp = await useCase.getAlfrescoImageData("");
  }
}
