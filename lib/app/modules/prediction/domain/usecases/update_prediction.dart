import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:eden/app/modules/prediction/domain/repositories/prediction_repository.dart';

import '../repositories/prediction_repository.dart';

abstract class UpdatePrediction {
  Future<void> call(String predictionId, Map<String, dynamic> document);
}

class UpdatePredictionImpl extends UpdatePrediction {
  final PredictionRepository predictionRepository;

  UpdatePredictionImpl(this.predictionRepository);

  @override
  Future<void> call(String predictionId, Map<String, dynamic> document) async {
    return await this.predictionRepository.updatePrediction(predictionId, document);
  }
}