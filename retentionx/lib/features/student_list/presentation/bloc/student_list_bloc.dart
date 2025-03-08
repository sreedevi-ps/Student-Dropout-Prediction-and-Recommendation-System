import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retentionx/features/student_list/data/model/student_model.dart';
import 'package:retentionx/features/student_list/data/repo/students_list_repo.dart';

part 'student_list_event.dart';
part 'student_list_state.dart';

class StudentListBloc extends Bloc<StudentListEvent, StudentListState> {
  StudentListBloc() : super(StudentListInitial()) {
    on<FetchStudentsList>((event, emit) async {
      emit(StudentListLoading());
      final res = await StudentsListRepo.getStudentsList();
      res.fold((left) {
        return emit(StudentListError(left));
      }, (right) {
        return emit(StudentListSuccess(right));
      });
    });
  }
}
