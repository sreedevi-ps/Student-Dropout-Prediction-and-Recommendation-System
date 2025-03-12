import 'package:flutter/material.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/features/view_recommendations/data/model/recommendation.dart';
import 'package:retentionx/features/view_recommendations/presentation/widgets/ratings.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendationTile extends StatelessWidget {
  const RecommendationTile({
    super.key,
    required this.recommendation,
  });
  final Recommendation recommendation;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.navBarColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.all(16),
      title: Text(
        recommendation.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Difficulty: ${recommendation.difficulty}\n'),
            Text('reviews: ${recommendation.reviews}\n'),
            Ratings(
              rating: recommendation.rating,
            ),
          ],
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.link),
        onPressed: () => launchURL(recommendation.url, context),
        // Icons.link,
        color: Colors.blue,
      ),
    );
  }

  Future<void> launchURL(String url, BuildContext context) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        throw Exception('Failed to launch URL: No app found to handle $url');
      }
    } catch (e) {
      if (!context.mounted) return;
      showCustomSnackBar(context, e.toString(), isError: true);
    }
  }
}
