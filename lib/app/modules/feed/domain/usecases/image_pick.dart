import 'package:eden/app/modules/feed/domain/repositories/feed_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../repositories/feed_repository.dart';

abstract class ImagePick {
  Future<PickedFile> call(ImageSource source);
}

class ImagePickImpl implements ImagePick {
  final FeedRepository feedRepository;

  ImagePickImpl(this.feedRepository);

  @override
  Future<PickedFile> call(ImageSource source) async {
    return feedRepository.imagePick(source);
  }
}