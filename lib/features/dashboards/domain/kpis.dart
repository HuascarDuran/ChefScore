class Kpis {
  final int totalReviews;
  final double avgProductStars;
  final double avgServiceStars;
  final int productsCount;
  final int branchesCount;
  final String? topProductName;

  const Kpis({
    required this.totalReviews,
    required this.avgProductStars,
    required this.avgServiceStars,
    required this.productsCount,
    required this.branchesCount,
    this.topProductName,
  });

  factory Kpis.fromMap(Map<String, dynamic> map) {
    double _toDouble(dynamic v) =>
        v == null ? 0.0 : (v is num ? v.toDouble() : double.tryParse('$v') ?? 0.0);
    int _toInt(dynamic v) =>
        v == null ? 0 : (v is num ? v.toInt() : int.tryParse('$v') ?? 0);

    return Kpis(
      totalReviews: _toInt(map['total_reviews']),
      avgProductStars: _toDouble(map['average_rating']),
      avgServiceStars: _toDouble(map['avg_service_stars']),
      productsCount: _toInt(map['products_count']),
      branchesCount: _toInt(map['total_branches']),
      topProductName: map['top_product_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'total_reviews': totalReviews,
        'average_rating': avgProductStars,
        'avg_service_stars': avgServiceStars,
        'products_count': productsCount,
        'total_branches': branchesCount,
        'top_product_name': topProductName,
      };

  Kpis copyWith({
    int? totalReviews,
    double? avgProductStars,
    double? avgServiceStars,
    int? productsCount,
    int? branchesCount,
    String? topProductName,
  }) => Kpis(
        totalReviews: totalReviews ?? this.totalReviews,
        avgProductStars: avgProductStars ?? this.avgProductStars,
        avgServiceStars: avgServiceStars ?? this.avgServiceStars,
        productsCount: productsCount ?? this.productsCount,
        branchesCount: branchesCount ?? this.branchesCount,
        topProductName: topProductName ?? this.topProductName,
      );
}