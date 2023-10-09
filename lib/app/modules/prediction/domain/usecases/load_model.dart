import 'package:eden/app/modules/prediction/domain/repositories/prediction_repository.dart';

import '../repositories/prediction_repository.dart';

abstract class LoadModel {
  void call();
}

class LoadModelImpl implements LoadModel {
  final PredictionRepository predictionRepository;

  LoadModelImpl(this.predictionRepository);

  @override
  void call() {
    return predictionRepository.loadModel();
  }
}