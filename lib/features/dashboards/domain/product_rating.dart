class ProductRating {
  final int productId;
  final String productName;
  final double avgStars;
  final int reviewsCount;

  const ProductRating({
    required this.productId,
    required this.productName,
    required this.avgStars,
    required this.reviewsCount,
  });

  factory ProductRating.fromMap(Map<String, dynamic> map) {
    double _toDouble(dynamic v) =>
        v == null ? 0.0 : (v is num ? v.toDouble() : double.tryParse('$v') ?? 0.0);
    int _toInt(dynamic v) =>
        v == null ? 0 : (v is num ? v.toInt() : int.tryParse('$v') ?? 0);

    return ProductRating(
      productId: _toInt(map['product_id']),
      productName: map['product_name'] ?? '',
      avgStars: _toDouble(map['avg_product_stars']),
      reviewsCount: _toInt(map['total_reviews']),
    );
  }

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_name': productName,
        'avg_product_stars': avgStars,
        'total_reviews': reviewsCount,
      };

  ProductRating copyWith({
    int? productId,
    String? productName,
    double? avgStars,
    int? reviewsCount,
  }) => ProductRating(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        avgStars: avgStars ?? this.avgStars,
        reviewsCount: reviewsCount ?? this.reviewsCount,
      );
}