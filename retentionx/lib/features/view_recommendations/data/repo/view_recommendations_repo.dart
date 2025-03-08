import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retentionx/core/api/api_urls.dart';
import 'package:retentionx/core/local_db/localdb.dart';

class ViewRecommendationsRepo {
  static final dio = Dio();

  viewRecommendations() async {
    try {
      // Map<String, dynamic>? user = await LocalDatabase().getData('user');

      // String studentId = user!['id'];

      final response = await dio.post(
        ApiUrls.viewRecommendations,
        data: {"query": "i want a course on aws cloud platform"},
      );

      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
