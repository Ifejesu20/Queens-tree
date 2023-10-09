

import 'data/datasource/prediction_datasource_impl.dart';
import 'data/repositories/prediction_repository_impl.dart';
import 'domain/usecases/get_prediction_by_id.dart';
import 'domain/usecases/load_model.dart';
import 'domain/usecases/prediction.dart';
import 'domain/usecases/save_prediction.dart';
import 'domain/usecases/update_prediction.dart';
import 'domain/usecases/upload_file.dart';
import 'presentation/pages/prediction/prediction_controller.dart';
import 'presentation/pages/prediction/prediction_page.dart';
import 'presentation/pages/preview/preview_page.dart';

class PredictionModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => LoadModelImpl(i())),
    Bind((i) => PredictionImpl(i())),
    Bind((i) => SavePredictionImpl(i())),
    Bind((i) => FirebaseDataSourceImpl()),
    Bind((i) => UploadFileImpl(i())),
    Bind((i) => PredictionRepositoryImpl(i())),
    Bind((i) => GetPredictionByIdImpl(i())),
    Bind((i) => UpdatePredictionImpl(i()))
  ];

  List<Bind> export = [
    $PredictionController
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (context, args) => PredictionPage(uid: args.data['uid'], image: args.data['image'])),
    ModularRouter('/preview/:id/update', child: (context, args) => PreviewPage())
  ];
}