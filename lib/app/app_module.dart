import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'modules/feed/feed_module.dart';
import 'modules/login/login_module.dart';
import 'modules/prediction/prediction_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    ...LoginModule().export,
    ...PredictionModule().export,
    ...FeedModule().export
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter("/login", module: LoginModule()),
    ModularRouter("/feed", module: FeedModule()),
    ModularRouter("/prediction", module: PredictionModule())
  ];

  @override
  Widget get bootstrap => AppWidget();
}