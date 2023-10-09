import '../../../prediction/domain/entities/prediction_entity.dart';

abstract class FeedDataSource {
  Stream<List<PredictionEntity>> getUserPredictions(String uid);
  Future<void> signOut();
}