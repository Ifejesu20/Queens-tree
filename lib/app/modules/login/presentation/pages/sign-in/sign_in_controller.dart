import 'package:eden/app/modules/login/domain/usecases/sign_in.dart';
import 'package:eden/app/modules/login/presentation/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'sign_in_controller.g.dart';

@Injectable()
class SignInController = _SignInController with _$SignInController;

abstract class _SignInController with Store {
  final SignIn signInUseCase;

  _SignInController(this.signInUseCase);

  @observable
  String email = "";

  @action
  setEmail(String value) => this.email = value;

  @observable
  String password = "";

  @action
  setPassword(String value) => this.password = value;

  @computed
  UserEntity get credential => UserEntity.user(email: email, password: password);

  signIn() async {
    var result = await signInUseCase(credential);
    result.fold((failure) {
      setEmail("");
      setPassword("");
      asuka.showSnackBar(SnackBar(content: Text(failure.toString())));
    }, (user) {
      setEmail("");
      setPassword("");
      Modular.to.pushNamed('/feed/', arguments: { "uid": user.uid });
    });
  }
}