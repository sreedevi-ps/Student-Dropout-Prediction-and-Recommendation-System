import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retentionx/features/view_recommendations/data/model/recommendation.dart';
import 'package:retentionx/features/view_recommendations/data/repo/view_recommendations_repo.dart';

part 'view_recommendations_event.dart';
part 'view_recommendations_state.dart';

class ViewRecommendationsBloc
    extends Bloc<ViewRecommendationsEvent, ViewRecommendationsState> {
  ViewRecommendationsBloc() : super(ViewRecommendationsInitial()) {
    on<GetRecommendations>((event, emit) async {
      emit(ViewRecommendationsLoading());
      try {
        if(event.query.isEmpty){
          emit(ViewRecommendationsError("Query cannot be empty"));
          return;
        }
        final res = await ViewRecommendationsRepo.viewRecommendations(
            query: event.query);
        res.fold((l) => emit(ViewRecommendationsError(l)),
            (r) => emit(ViewRecommendationsLoaded(r)));
      } catch (e) {
        emit(ViewRecommendationsError(e.toString()));
      }
    });
  }
}
