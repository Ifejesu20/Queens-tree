import 'package:eden/app/modules/feed/data/datasource/feed_datasource.dart';
import 'package:eden/app/modules/feed/domain/repositories/feed_repository.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:image_picker/image_picker.dart';

import '../../../prediction/domain/entities/prediction_entity.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasource/feed_datasource.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource feedDataSource;

  FeedRepositoryImpl(this.feedDataSource);

  @override
  Future<PickedFile> imagePick(ImageSource source) async {
    PickedFile image = await ImagePicker().getImage(source: source);
    if(image == null) return null;
    return image;
  }

  @override
  Stream<List<PredictionEntity>> getUserPredictions(String uid) {
    return feedDataSource.getUserPredictions(uid);
  }

  @override
  Future<void> signOut() async {
    await feedDataSource.signOut();
  }
}