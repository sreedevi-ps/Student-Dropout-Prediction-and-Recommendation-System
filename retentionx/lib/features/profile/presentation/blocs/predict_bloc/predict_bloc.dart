import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retentionx/features/profile/data/repo/profile_repo.dart';

part 'predict_event.dart';
part 'predict_state.dart';

class PredictBloc extends Bloc<PredictEvent, PredictState> {
  PredictBloc() : super(PredictInitial()) {
    on<GetPrediction>((event, emit) async {
      emit(PredictLoading());
      final response = await ProfileRepo.predict(studentId: event.studentId);
      response.fold(
        (l) => emit(PredictError(l)),
        (r) {
          if (r == "dropout") {
            emit(PredictDropOut(r));
          } else {
            emit(PredictGraduate(r));
          }
        },
      );
    });
  }
}
