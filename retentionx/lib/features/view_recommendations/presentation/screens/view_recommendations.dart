import 'package:flutter/material.dart';
import 'package:retentionx/features/view_recommendations/data/repo/view_recommendations_repo.dart';

class ScreenViewRecommendations extends StatefulWidget {
  const ScreenViewRecommendations({super.key});

  @override
  State<ScreenViewRecommendations> createState() =>
      _ScreenViewRecommendationsState();
}

class _ScreenViewRecommendationsState extends State<ScreenViewRecommendations> {
  @override
  void initState() {
    ViewRecommendationsRepo().viewRecommendations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('View Recommendations'),
      ),
    );
  }
}
