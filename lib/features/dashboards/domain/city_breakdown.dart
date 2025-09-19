class CityBreakdown {
  final String city;
  final int totalReviews;
  final double avgProductStars;
  final double avgServiceStars;

  const CityBreakdown({
    required this.city,
    required this.totalReviews,
    required this.avgProductStars,
    required this.avgServiceStars,
  });

  factory CityBreakdown.fromMap(Map<String, dynamic> map) {
    double _toDouble(dynamic v) =>
        v == null ? 0.0 : (v is num ? v.toDouble() : double.tryParse('$v') ?? 0.0);
    int _toInt(dynamic v) =>
        v == null ? 0 : (v is num ? v.toInt() : int.tryParse('$v') ?? 0);

    return CityBreakdown(
      city: (map['city'] ?? '').toString(),
      totalReviews: _toInt(map['total_reviews']),
      avgProductStars: _toDouble(map['avg_product_stars']),
      avgServiceStars: _toDouble(map['avg_service_stars']),
    );
  }

  Map<String, dynamic> toJson() => {
        'city': city,
        'total_reviews': totalReviews,
        'avg_product_stars': avgProductStars,
        'avg_service_stars': avgServiceStars,
      };

  CityBreakdown copyWith({
    String? city,
    int? totalReviews,
    double? avgProductStars,
    double? avgServiceStars,
  }) => CityBreakdown(
        city: city ?? this.city,
        totalReviews: totalReviews ?? this.totalReviews,
        avgProductStars: avgProductStars ?? this.avgProductStars,
        avgServiceStars: avgServiceStars ?? this.avgServiceStars,
      );
}