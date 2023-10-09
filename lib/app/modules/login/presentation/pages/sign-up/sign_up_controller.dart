import 'package:eden/app/modules/login/domain/usecases/sign_up.dart';
import 'package:eden/app/modules/login/presentation/entity/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part "sign_up_controller.g.dart";

@Injectable()
class SignUpController = _SignUpController with _$SignUpController;

abstract class _SignUpController with Store {
  final SignUp signUpUseCase;

  _SignUpController(this.signUpUseCase);

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

  signUp() async {
    var result = await signUpUseCase(credential);
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