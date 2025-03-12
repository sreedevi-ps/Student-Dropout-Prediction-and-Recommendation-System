
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retentionx/core/api/api_urls.dart';
import 'package:retentionx/core/extensions/either_extensions.dart';
import 'package:retentionx/features/view_recommendations/data/model/recommendation.dart';

class ViewRecommendationsRepo {
  static final dio = Dio();

  static EitherFuture<List<Recommendation>> viewRecommendations({
    required String query,
  }) async {
    try {
      final response = await dio.post(
        ApiUrls.viewRecommendations,
        data: {"query": query},
      );

      Map<String, dynamic> data = response.data;

      if (data['status'] == "success") {
        List<Recommendation> recommendations = [];
        for (var item in data['recommendations']) {
          recommendations.add(Recommendation.fromJson(item));
        }
        return right(recommendations);
      } else {
        return left(data['message']);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}

//"i want a course on aws cloud platform"
