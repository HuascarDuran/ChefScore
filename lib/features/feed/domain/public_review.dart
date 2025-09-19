import 'package:equatable/equatable.dart';

class PublicReview extends Equatable {
  final String id;
  final String deviceId;
  final String? productId;
  final String? productName;
  final int rating; // 1..5
  final String? title;
  final String? comment;
  final DateTime createdAt;

  const PublicReview({
    required this.id,
    required this.deviceId,
    this.productId,
    this.productName,
    required this.rating,
    this.title,
    this.comment,
    required this.createdAt,
  });

  factory PublicReview.fromMap(Map<String, dynamic> map) {
    return PublicReview(
      id: map['id'] as String,
      deviceId: map['device_id'] as String,
      productId: map['product_id'] as String?,
      productName: map['product_name'] as String? ?? map['product'] as String?,
      rating: (map['rating'] as num).toInt(),
      title: map['title'] as String?,
      comment: map['comment'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  @override
  List<Object?> get props => [id, rating, comment, productName, createdAt];
}