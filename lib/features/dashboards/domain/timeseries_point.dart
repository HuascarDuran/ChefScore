class TimeseriesPoint {
  final DateTime date;
  final int reviewsCount;
  final double avgProductStars;
  final double avgServiceStars;

  int get count => reviewsCount; // alias para compatibilidad

  const TimeseriesPoint({
    required this.date,
    required this.reviewsCount,
    required this.avgProductStars,
    required this.avgServiceStars,
  });

  factory TimeseriesPoint.fromMap(Map<String, dynamic> map) {
    DateTime _toDate(dynamic v) =>
        v == null ? DateTime.now() : DateTime.tryParse(v.toString()) ?? DateTime.now();
    double _toDouble(dynamic v) =>
        v == null ? 0.0 : (v is num ? v.toDouble() : double.tryParse('$v') ?? 0.0);
    int _toInt(dynamic v) =>
        v == null ? 0 : (v is num ? v.toInt() : int.tryParse('$v') ?? 0);

    return TimeseriesPoint(
      date: _toDate(map['created_at']),
      reviewsCount: _toInt(map['reviews_count']),
      avgProductStars: _toDouble(map['avg_product_stars']),
      avgServiceStars: _toDouble(map['avg_service_stars']),
    );
  }

  Map<String, dynamic> toJson() => {
        'created_at': date.toIso8601String(),
        'reviews_count': reviewsCount,
        'avg_product_stars': avgProductStars,
        'avg_service_stars': avgServiceStars,
      };

  TimeseriesPoint copyWith({
    DateTime? date,
    int? reviewsCount,
    double? avgProductStars,
    double? avgServiceStars,
  }) => TimeseriesPoint(
        date: date ?? this.date,
        reviewsCount: reviewsCount ?? this.reviewsCount,
        avgProductStars: avgProductStars ?? this.avgProductStars,
        avgServiceStars: avgServiceStars ?? this.avgServiceStars,
      );
}