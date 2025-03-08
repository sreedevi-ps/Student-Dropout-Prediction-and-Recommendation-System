import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retentionx/core/api/api_urls.dart';
import 'package:retentionx/core/extensions/either_extensions.dart';
import 'package:retentionx/features/student_list/data/model/student_model.dart';

class StudentsListRepo {
  static final dio = Dio();

  static EitherFuture<List<StudentListModel>> getStudentsList() async {
    try {
      final response = await dio.get(ApiUrls.studentsList);
      Map<String, dynamic> data = response.data;
      if (data['status'] == "success") {
        List students = data['students'];

        List<StudentListModel> studentList =
            students.map((e) => StudentListModel.fromJson(e)).toList();
        return right(studentList);
      } else {
        return left(data['message']);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
