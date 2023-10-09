import 'package:eden/app/modules/feed/domain/usecases/get_user_predictions.dart';
import 'package:eden/app/modules/feed/domain/usecases/image_pick.dart';
import 'package:eden/app/modules/feed/domain/usecases/sign_out.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'feed_controller.g.dart';

@Injectable()
class FeedController = _FeedController with _$FeedController;

abstract class _FeedController with Store {
  final ImagePick imagePickUseCase;
  final GetUserPredictions getUserPredictionsUseCase;
  final SignOut signOutUseCase;

  _FeedController(this.imagePickUseCase, this.getUserPredictionsUseCase, this.signOutUseCase);

  Future<PickedFile> imagePick(ImageSource source) async {
    try {
      return await imagePickUseCase(source);
    } on Exception catch(ex) {
      throw new Exception(ex.toString());
    }
  }

  @observable
  ObservableStream<List<PredictionEntity>> predictionList;

  @action
  void getList(String uid) {
    predictionList = getUserPredictionsUseCase(uid).asObservable();
  }

  @action
  Future<void> signOut() async => await signOutUseCase();
}