class ProductPopularity {
  final int productId;
  final String productName;
  final int totalReviews;
  final double avgStars;

  const ProductPopularity({
    required this.productId,
    required this.productName,
    required this.totalReviews,
    required this.avgStars,
  });

  factory ProductPopularity.fromMap(Map<String, dynamic> map) {
    double _toDouble(dynamic v) =>
        v == null ? 0.0 : (v is num ? v.toDouble() : double.tryParse('$v') ?? 0.0);
    int _toInt(dynamic v) =>
        v == null ? 0 : (v is num ? v.toInt() : int.tryParse('$v') ?? 0);

    return ProductPopularity(
      productId: _toInt(map['product_id']),
      productName: map['product_name'] ?? '',
      totalReviews: _toInt(map['total_reviews']),
      avgStars: _toDouble(map['avg_product_stars']),
    );
  }

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_name': productName,
        'total_reviews': totalReviews,
        'avg_product_stars': avgStars,
      };

  ProductPopularity copyWith({
    int? productId,
    String? productName,
    int? totalReviews,
    double? avgStars,
  }) => ProductPopularity(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        totalReviews: totalReviews ?? this.totalReviews,
        avgStars: avgStars ?? this.avgStars,
      );
}