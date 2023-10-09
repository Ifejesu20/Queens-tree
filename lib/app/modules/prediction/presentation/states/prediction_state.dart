import 'package:image_picker/image_picker.dart';

abstract class PredictionState {}

class StartState implements PredictionState {
  const StartState();
}

class LoadingState implements PredictionState {
  const LoadingState();
}

class SuccessState implements PredictionState {
  final List<dynamic> list;
  const SuccessState(this.list);
}

class ErrorState implements PredictionState {
  final Exception error;
  const ErrorState(this.error);
}