// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SignUpController = BindInject(
  (i) => SignUpController(i<SignUp>()),
  singleton: true,
  lazy: true
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpController on _SignUpController, Store {
  Computed<UserEntity> _$credentialComputed;

  @override
  UserEntity get credential =>
      (_$credentialComputed ??= Computed<UserEntity>(() => super.credential,
              name: '_SignUpController.credential'))
          .value;

  final _$emailAtom = Atom(name: '_SignUpController.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_SignUpController.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$_SignUpControllerActionController =
      ActionController(name: '_SignUpController');

  @override
  dynamic setEmail(String value) {
    final _$actionInfo = _$_SignUpControllerActionController.startAction(
        name: '_SignUpController.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_SignUpControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPassword(String value) {
    final _$actionInfo = _$_SignUpControllerActionController.startAction(
        name: '_SignUpController.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_SignUpControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
credential: ${credential}
    ''';
  }
}
