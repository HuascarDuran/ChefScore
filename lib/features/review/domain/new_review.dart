class NewReview {
  final String productId;
  final String branchId;
  final int productStars;
  final int serviceStars;
  final String comment;

  NewReview({
    required this.productId,
    required this.branchId,
    required this.productStars,
    required this.serviceStars,
    required this.comment,
  });

  Map<String, dynamic> toMap(String deviceId) {
    return {
      'product_id': productId,
      'branch_id': branchId,
      'product_stars': productStars,
      'service_stars': serviceStars,
      'comment': comment,
      'device_id': deviceId,
    };
  }
}