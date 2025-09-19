class Review {
  final String? comment;
  final int productStars;
  final int serviceStars;
  final DateTime createdAt;

  Review({
    required this.comment,
    required this.productStars,
    required this.serviceStars,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json['comment'],
      productStars: json['product_stars'],
      serviceStars: json['service_stars'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}