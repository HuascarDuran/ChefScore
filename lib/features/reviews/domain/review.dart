class Review {
  final String id;
  final String orderId;
  final int productStars; // 1..5
  final int serviceStars; // 1..5
  final String? comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.orderId,
    required this.productStars,
    required this.serviceStars,
    this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json['id'] as String,
    orderId: json['orderId'] as String,
    productStars: json['productStars'] as int,
    serviceStars: json['serviceStars'] as int,
    comment: json['comment'] as String?,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'orderId': orderId,
    'productStars': productStars,
    'serviceStars': serviceStars,
    'comment': comment,
    'createdAt': createdAt.toIso8601String(),
  };
}
