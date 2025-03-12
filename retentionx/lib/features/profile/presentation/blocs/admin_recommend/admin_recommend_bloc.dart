import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retentionx/features/profile/data/repo/profile_repo.dart';

part 'admin_recommend_event.dart';
part 'admin_recommend_state.dart';

class AdminRecommendBloc
    extends Bloc<AdminRecommendEvent, AdminRecommendState> {
  AdminRecommendBloc() : super(AdminRecommendInitial()) {
    on<AdminRecommendButtonPressed>((event, emit) async {
      emit(AdminRecommendLoading());
      try {
        // Call the API to get the recommendations
        final response = await ProfileRepo.adminRecommend(
            studentId: event.studentId, recommendation: event.recommendation);

        response.fold(
          (l) => emit(AdminRecommendError(l)),
          (r) => emit(AdminRecommendLoaded()),
        );
      } catch (e) {
        emit(AdminRecommendError('Failed to load recommendations'));
      }
    });
  }
}
