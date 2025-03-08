import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_recommendations_event.dart';
part 'view_recommendations_state.dart';

class ViewRecommendationsBloc extends Bloc<ViewRecommendationsEvent, ViewRecommendationsState> {
  ViewRecommendationsBloc() : super(ViewRecommendationsInitial()) {
    on<ViewRecommendationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
