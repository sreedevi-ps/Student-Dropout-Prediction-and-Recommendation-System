part of 'bulk_upload_bloc.dart';

@immutable
sealed class BulkUploadState {}

final class BulkUploadInitial extends BulkUploadState {}


final class BulkUploadLoading extends BulkUploadState {}

//file uploaded successfully
final class BulkUploadSuccess extends BulkUploadState {
  final String message;

  BulkUploadSuccess(this.message);
}

//error in uploading file
final class BulkUploadError extends BulkUploadState {
  final String message;

  BulkUploadError(this.message);
}