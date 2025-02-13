import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'student_data_entry_event.dart';
part 'student_data_entry_state.dart';

class StudentDataEntryBloc extends Bloc<StudentDataEntryEvent, StudentDataEntryState> {
  StudentDataEntryBloc() : super(StudentDataEntryInitial()) {
    on<StudentDataEntryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
