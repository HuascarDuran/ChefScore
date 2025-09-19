class BranchService {
  final int branchId;
  final String branchName;
  final double avgServiceStars;
  final int totalReviews;

  const BranchService({
    required this.branchId,
    required this.branchName,
    required this.avgServiceStars,
    required this.totalReviews,
  });

  factory BranchService.fromMap(Map<String, dynamic> map) {
    double _toDouble(dynamic v) =>
        v == null ? 0.0 : (v is num ? v.toDouble() : double.tryParse('$v') ?? 0.0);
    int _toInt(dynamic v) =>
        v == null ? 0 : (v is num ? v.toInt() : int.tryParse('$v') ?? 0);

    return BranchService(
      branchId: _toInt(map['branch_id']),
      branchName: map['branch_name'] ?? '',
      avgServiceStars: _toDouble(map['avg_service_stars']),
      totalReviews: _toInt(map['total_reviews']),
    );
  }

  Map<String, dynamic> toJson() => {
        'branch_id': branchId,
        'branch_name': branchName,
        'avg_service_stars': avgServiceStars,
        'total_reviews': totalReviews,
      };

  BranchService copyWith({
    int? branchId,
    String? branchName,
    double? avgServiceStars,
    int? totalReviews,
  }) => BranchService(
        branchId: branchId ?? this.branchId,
        branchName: branchName ?? this.branchName,
        avgServiceStars: avgServiceStars ?? this.avgServiceStars,
        totalReviews: totalReviews ?? this.totalReviews,
      );
}