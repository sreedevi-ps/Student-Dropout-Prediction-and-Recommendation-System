part of 'view_recommendations_bloc.dart';

@immutable
sealed class ViewRecommendationsState {}

final class ViewRecommendationsInitial extends ViewRecommendationsState {}

final class ViewRecommendationsLoading extends ViewRecommendationsState {}

final class ViewRecommendationsLoaded extends ViewRecommendationsState {
  final List<Recommendation> recommendations;

  ViewRecommendationsLoaded(this.recommendations);
}

final class ViewRecommendationsError extends ViewRecommendationsState {
  final String message;

  ViewRecommendationsError(this.message);
}
