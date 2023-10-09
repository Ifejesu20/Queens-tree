import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eden/app/modules/prediction/domain/repositories/prediction_repository.dart';

import '../repositories/prediction_repository.dart';

abstract class GetPredictionById {
  Future<DocumentSnapshot> call(String uid);
}

class GetPredictionByIdImpl implements GetPredictionById {
  final PredictionRepository predictionRepository;

  GetPredictionByIdImpl(this.predictionRepository);

  @override
  Future<DocumentSnapshot> call(String uid) async {
    return await predictionRepository.getPredictionById(uid);
  }
}