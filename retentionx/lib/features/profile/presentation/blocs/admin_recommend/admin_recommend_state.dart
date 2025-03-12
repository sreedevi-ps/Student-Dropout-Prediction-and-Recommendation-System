part of 'admin_recommend_bloc.dart';

@immutable
sealed class AdminRecommendState {}

final class AdminRecommendInitial extends AdminRecommendState {}

//loading
final class AdminRecommendLoading extends AdminRecommendState {}

//loaded
final class AdminRecommendLoaded extends AdminRecommendState {
 

  AdminRecommendLoaded();
}


//error
final class AdminRecommendError extends AdminRecommendState {
  final String message;

  AdminRecommendError(this.message);
}