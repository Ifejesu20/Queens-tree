import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:eden/app/modules/prediction/domain/repositories/prediction_repository.dart';

import '../entities/prediction_entity.dart';
import '../repositories/prediction_repository.dart';

abstract class SavePrediction {
  Future<DocumentReference> call(PredictionEntity prediction);
}

class SavePredictionImpl implements SavePrediction {
  final PredictionRepository predictionRepository;

  SavePredictionImpl(this.predictionRepository);

  @override
  Future<DocumentReference> call(PredictionEntity prediction) {
    return predictionRepository.savePrediction(prediction);
  }
}