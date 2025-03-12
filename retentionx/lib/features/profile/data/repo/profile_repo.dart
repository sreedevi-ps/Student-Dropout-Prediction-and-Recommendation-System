import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retentionx/core/api/api_urls.dart';
import 'package:retentionx/core/extensions/either_extensions.dart';
import 'package:retentionx/core/local_db/localdb.dart';
import 'package:retentionx/features/profile/data/model/student_profile_model.dart';

class ProfileRepo {
  static final dio = Dio();

  static EitherFuture<StudentProfileModel> studentProfile({
    String? studentId,
  }) async {
    try {
      if (studentId == null) {
        Map<String, dynamic>? user = await LocalDatabase().getData('user');

        studentId = user!['id'];
      }

      final response = await dio.get(
        "${ApiUrls.studentProfile}$studentId",
      );

      Map<String, dynamic> data = response.data;

      if (data['status'] == 'success') {
        return right(StudentProfileModel.fromJson(data));
      } else {
        return left(data['message']);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  //predict
  static EitherFuture<String> predict({
    String? studentId,
  }) async {
    try {
      if (studentId == null) {
        Map<String, dynamic>? user = await LocalDatabase().getData('user');

        studentId = user!['id'];
      }
      final response =
          await dio.post(ApiUrls.predict, data: {"student_id": studentId});
      Map<String, dynamic> responseData = response.data;
      if (responseData['status'] == "success") {
        return right(
          response.data['prediction'],
        );
      } else {
        return left(response.data['message']);
      }
    } catch (e) {
      return left(e.toString());
    }
  }




  //admin recommend
  static EitherFuture<String> adminRecommend({
   required String studentId,
   required String recommendation,    
  }) async {
    try {
   
      final response =
          await dio.post(ApiUrls.adminRecommend, data: {
            "query": recommendation,
            "student_id": studentId});
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
