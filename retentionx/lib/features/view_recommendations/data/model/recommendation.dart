
class Recommendation {
  final String difficulty;
  final double rating;
  final String reviews;
  final String title;
  final String url;

  Recommendation({
    required this.difficulty,
    required this.rating,
    required this.reviews,
    required this.title,
    required this.url,
  });

  // Factory method to create an instance from a map (useful for parsing JSON)
  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      difficulty: json['difficulty'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      title: json['title'],
      url: json['url'],
    );
  }

  // Method to convert the instance back to a map (useful for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'difficulty': difficulty,
      'rating': rating,
      'reviews': reviews,
      'title': title,
      'url': url,
    };
  }
}