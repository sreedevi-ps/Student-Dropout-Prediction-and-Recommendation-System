part of 'predict_bloc.dart';

@immutable
sealed class PredictEvent {}


//get prediction
class GetPrediction extends PredictEvent {
  final String studentId;
  GetPrediction(this.studentId);
}

