part of 'predict_bloc.dart';

@immutable
sealed class PredictState {}

final class PredictInitial extends PredictState {}

//loading
final class PredictLoading extends PredictState {}

//loaded
final class PredictDropOut extends PredictState {
  final String prediction;
  PredictDropOut(this.prediction);
}

final class PredictGraduate extends PredictState {
  final String prediction;
  PredictGraduate(this.prediction);
}
//error
final class PredictError extends PredictState {
  final String message;
  PredictError(this.message);
}
