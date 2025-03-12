import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retentionx/features/data_entry/data/repo/student_data_entry_repo.dart';

part 'bulk_upload_event.dart';
part 'bulk_upload_state.dart';

class BulkUploadBloc extends Bloc<BulkUploadEvent, BulkUploadState> {
  BulkUploadBloc() : super(BulkUploadInitial()) {
    on<UploadButtonPressed>((event, emit)async {
      emit(BulkUploadLoading());
      try{
 final res = await StudentDataEntryRepo.uploadFile();
      res.fold(
        (l) => emit(BulkUploadError(l)),
        (r) => emit(BulkUploadSuccess( r)),
      );
      }
      catch(e){
        emit(BulkUploadError(e.toString()));
      }
     
    });
  }
}
