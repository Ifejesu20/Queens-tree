import 'package:eden/app/modules/login/data/repositories/user_repository_impl.dart';
import 'package:eden/app/modules/login/domain/usecases/sign_in.dart';
import 'package:eden/app/modules/login/domain/usecases/sign_up.dart';
import 'package:eden/app/modules/login/presentation/pages/sign-in/sign_in_controller.dart';
import 'package:eden/app/modules/login/presentation/pages/sign-in/sign_in_page.dart';
import 'package:eden/app/modules/login/presentation/pages/sign-up/sign_up_controller.dart';
import 'package:eden/app/modules/login/presentation/pages/sign-up/sign_up_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/repositories/user_repository_impl.dart';
import 'domain/usecases/sign_in.dart';
import 'domain/usecases/sign_up.dart';
import 'presentation/pages/sign-in/sign_in_controller.dart';
import 'presentation/pages/sign-in/sign_in_page.dart';
import 'presentation/pages/sign-up/sign_up_controller.dart';
import 'presentation/pages/sign-up/sign_up_page.dart';

class LoginModule extends ChildModule {
  List<Bind> export = [
    $SignUpController,
    $SignInController
  ];

  @override
  List<Bind> get binds => [
    Bind((i) => SignUpImpl(i())),
    Bind((i) => SignInImpl(i())),
    Bind((i) => UserRepositoryImpl()),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (context, args) => SignInPage()),
    ModularRouter('/sign-up', child: (context, args) => SignUpPage())
  ];
}