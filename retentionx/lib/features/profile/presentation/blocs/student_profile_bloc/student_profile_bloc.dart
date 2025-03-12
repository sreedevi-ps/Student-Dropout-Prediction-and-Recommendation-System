import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retentionx/features/profile/data/model/student_profile_model.dart';
import 'package:retentionx/features/profile/data/repo/profile_repo.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class StudentProfileBloc extends Bloc<StudentProfileEvent, StudentProfileState> {
  StudentProfileBloc() : super(StudentProfileInitial()) {
    on<GetStudentProfile>((event, emit) async {
      emit(StudentProfileLoading());
      final response = await ProfileRepo.studentProfile(studentId: event.studentId);
      response.fold(
        (l) => emit(StudentProfileError(l)),
        (r) => emit(StudentProfileLoaded(r)),
      );
    });
  }
}
