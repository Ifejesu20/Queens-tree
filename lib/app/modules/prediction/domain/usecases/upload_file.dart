import 'dart:io';
import 'package:eden/app/modules/prediction/domain/repositories/prediction_repository.dart';

import '../repositories/prediction_repository.dart';

abstract class UploadFile {
  Future<String> call(File file, String folder, String name, String extension);
}

class UploadFileImpl implements UploadFile {
  final PredictionRepository predictionRepository;

  UploadFileImpl(this.predictionRepository);

  @override
  Future<String> call(File file, String folder, String name, String extension) async {
    return await predictionRepository.uploadFile(file, folder, name, extension);
  }
}