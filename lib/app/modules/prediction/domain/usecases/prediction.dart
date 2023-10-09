import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/prediction/domain/repositories/prediction_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../repositories/prediction_repository.dart';

abstract class Prediction {
  Future<Either<Exception, List<dynamic>>> call(PickedFile image);
}

class PredictionImpl implements Prediction {
  final PredictionRepository predictionRepository;

  PredictionImpl(this.predictionRepository);

  @override
  Future<Either<Exception, List<dynamic>>> call(PickedFile image) async {
    return await predictionRepository.prediction(image);
  }
}