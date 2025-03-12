part of 'admin_recommend_bloc.dart';

@immutable
sealed class AdminRecommendEvent {}

class AdminRecommendButtonPressed extends AdminRecommendEvent {
  final String studentId;
  final String recommendation;

  AdminRecommendButtonPressed({
    required this.studentId,
    required this.recommendation,
  });
}
