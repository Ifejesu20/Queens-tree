import 'package:eden/app/modules/feed/domain/repositories/feed_repository.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';

import '../../../prediction/domain/entities/prediction_entity.dart';
import '../repositories/feed_repository.dart';

abstract class GetUserPredictions {
  Stream<List<PredictionEntity>> call(String uid);
}

class GetUserPredictionsImpl implements GetUserPredictions {
  final FeedRepository feedRepository;

  GetUserPredictionsImpl(this.feedRepository);

  @override
  Stream<List<PredictionEntity>> call(String uid) {
    return feedRepository.getUserPredictions(uid);
  }
}