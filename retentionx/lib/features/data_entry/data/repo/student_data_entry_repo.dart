import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retentionx/core/api/api_urls.dart';
import 'package:retentionx/core/extensions/either_extensions.dart';
import 'package:retentionx/features/data_entry/data/model/student_entry_model.dart';

class StudentDataEntryRepo {
  //dio
  static final dio = Dio();

// static EitherFuture<String> 
static addStudentData ({
    required StudentDataEntryModel studentDataEntryModel,
  })async {
    try {




      
    
      final res = await dio.post(ApiUrls.studentDataEntry,
          data: studentDataEntryModel.toJson());

      
    } catch (e) {
      print(e);
    }
  }
}
