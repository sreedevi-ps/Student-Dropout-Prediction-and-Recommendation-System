import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retentionx/features/data_entry/data/model/student_entry_model.dart';
import 'package:retentionx/features/data_entry/data/repo/student_data_entry_repo.dart';

part 'student_data_entry_event.dart';
part 'student_data_entry_state.dart';

class StudentDataEntryBloc extends Bloc<StudentDataEntryEvent, StudentDataEntryState> {
  StudentDataEntryBloc() : super(StudentDataEntryInitial()) {
    on<StudentDataEntryButtonPressed>((event, emit) async {
      emit(StudentDataEntryLoading());
      try {
        final res = await  StudentDataEntryRepo.addStudent(
                              student: event.studentDataEntryModel);
      res.fold((l) => emit(StudentDataEntryError(message: l)),
          (r) => emit(StudentDataEntrySuccess(message: r)));
       
      } catch (e) {
        emit(StudentDataEntryError(message: e.toString()));
      }
    });
  }
}
