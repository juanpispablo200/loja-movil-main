import 'dart:typed_data';

import 'package:loja_movil/src/domain/repository/api_repository.dart';


class AlfrescoUseCase {
  final ApiRepository apiRepositoryInterface;

  AlfrescoUseCase({
    required this.apiRepositoryInterface,
  });

  Future<Uint8List?> getAlfrescoImageData(String fileId) async {
    return await apiRepositoryInterface.getAlfrescoImageData(fileId);
  }

}
