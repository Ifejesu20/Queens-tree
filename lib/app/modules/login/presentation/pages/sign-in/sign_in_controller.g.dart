// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SignInController = BindInject(
  (i) => SignInController(i<SignIn>()),
  singleton: true,
  lazy: true
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInController on _SignInController, Store {
  Computed<UserEntity> _$credentialComputed;

  @override
  UserEntity get credential =>
      (_$credentialComputed ??= Computed<UserEntity>(() => super.credential,
              name: '_SignInController.credential'))
          .value;

  final _$emailAtom = Atom(name: '_SignInController.email');

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

  final _$passwordAtom = Atom(name: '_SignInController.password');

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

  final _$_SignInControllerActionController =
      ActionController(name: '_SignInController');

  @override
  dynamic setEmail(String value) {
    final _$actionInfo = _$_SignInControllerActionController.startAction(
        name: '_SignInController.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_SignInControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPassword(String value) {
    final _$actionInfo = _$_SignInControllerActionController.startAction(
        name: '_SignInController.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_SignInControllerActionController.endAction(_$actionInfo);
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
