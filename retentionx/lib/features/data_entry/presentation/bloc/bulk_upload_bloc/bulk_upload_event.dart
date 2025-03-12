part of 'bulk_upload_bloc.dart';

@immutable
sealed class BulkUploadEvent {}

//button pressed
class UploadButtonPressed extends BulkUploadEvent {


  UploadButtonPressed();
}
