import 'package:dio/dio.dart';
import 'package:retentionx/core/api/api_urls.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retentionx/core/extensions/either_extensions.dart';
import 'package:retentionx/features/auth/data/model/user_logn_model.dart';

class AuthRepo {
  static final dio = Dio();

  static EitherFuture<UserLoginModel> login(
      {required String userName, required String password}) async {
    try {
      FormData formData = FormData.fromMap({
        "username": userName,
        "password": password,
      });

      final response = await dio.post(ApiUrls.loginApi, data: formData);
       Map<String, dynamic> responseData = response.data;
      if (responseData['status'] == "success") {
        UserLoginModel userloginmodel = UserLoginModel(
            isAdmin: responseData["id"]=="admin", id: responseData["id"], user: responseData["user"]);
        return right(userloginmodel);
      } else {
        return left(response.data['message']);
      }
    } catch (e) {
      return left(e.toString());
    }
  }



}
