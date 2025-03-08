
import 'package:dio/dio.dart';
import 'package:retentionx/core/api/api_urls.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retentionx/core/extensions/either_extensions.dart';
import 'package:retentionx/features/data_entry/data/model/student_entry_model.dart';
class StudentDataEntryRepo {
static final dio = Dio();
  static EitherFuture<String> addStudent(
      {required StudentDataEntryModel student}) async {
    try {
      

      final response = await dio.post(ApiUrls.studentDataEntry, data:student.toJson());
       Map<String, dynamic> responseData = response.data;
      if (responseData['status'] == "success") {
        return right(
          response.data['message'],
        );
      } else {
        return left(response.data['message']); 
      }
    } catch (e) {
      return left(e.toString());
  }
  }
}