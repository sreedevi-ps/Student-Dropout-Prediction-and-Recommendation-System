import 'package:dio/dio.dart';
import 'package:retentionx/core/api/api_urls.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retentionx/core/extensions/either_extensions.dart';

class AuthRepo {
  static final dio = Dio();

  static EitherFuture<String> login(
      {required String userName, required String password}) async {
    try {
      FormData formData = FormData.fromMap({
        "username": userName,
        "password": password,
      });

      final response = await dio.post(ApiUrls.loginApi, data: formData);
       Map<String, dynamic> responseData = response.data;
      if (responseData['status'] == "success") {
        return right(
          response.data['user'],
        );
      } else {
        return left(response.data['message']);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
