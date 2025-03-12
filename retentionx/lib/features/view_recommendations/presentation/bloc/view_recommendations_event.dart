part of 'view_recommendations_bloc.dart';

@immutable
sealed class ViewRecommendationsEvent {}

//get recommendations
class GetRecommendations extends ViewRecommendationsEvent {
  final String query;

  GetRecommendations(this.query);
}
