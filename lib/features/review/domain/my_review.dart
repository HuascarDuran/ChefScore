

class MyReview {
  final int id;
  final int productId;
  final String productName;
  final int branchId;
  final String branchName;
  final int stars;
  final String comment;
  final DateTime createdAt;

  const MyReview({
    required this.id,
    required this.productId,
    required this.productName,
    required this.branchId,
    required this.branchName,
    required this.stars,
    required this.comment,
    required this.createdAt,
  });

  factory MyReview.fromMap(Map<String, dynamic> map) {
    return MyReview(
      id: map['id'] as int,
      productId: map['product_id'] as int,
      productName: map['product_name'] as String? ?? '',
      branchId: map['branch_id'] as int,
      branchName: map['branch_name'] as String? ?? '',
      stars: map['stars'] as int,
      comment: map['comment'] as String? ?? '',
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}