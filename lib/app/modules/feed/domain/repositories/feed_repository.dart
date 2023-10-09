import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:image_picker/image_picker.dart';

import '../../../prediction/domain/entities/prediction_entity.dart';

abstract class FeedRepository {
  Future<PickedFile> imagePick(ImageSource source);
  Stream<List<PredictionEntity>> getUserPredictions(String uid);
  Future<void> signOut();
}