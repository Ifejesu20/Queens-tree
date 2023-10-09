// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $PredictionController = BindInject(
  (i) => PredictionController(
    i<LoadModel>(),
    i<Prediction>(),
    i<UploadFile>(),
    i<SavePrediction>(),
    i<GetPredictionById>(),
    i<UpdatePrediction>()
  ),
  singleton: true,
  lazy: true
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PredictionController on _PredictionController, Store {
  final _$stateAtom = Atom(name: '_PredictionController.state');

  @override
  PredictionState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(PredictionState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_PredictionControllerActionController =
      ActionController(name: '_PredictionController');

  @override
  dynamic setState(PredictionState value) {
    final _$actionInfo = _$_PredictionControllerActionController.startAction(
        name: '_PredictionController.setState');
    try {
      return super.setState(value);
    } finally {
      _$_PredictionControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
