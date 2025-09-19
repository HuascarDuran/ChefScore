import 'package:equatable/equatable.dart';

class PublicReview extends Equatable {
  final String id;
  final String deviceId;
  final String productId;
  final String branchId;

  final String? productName;
  final String? branchName;

  final int productStars; // 1..5
  final int serviceStars; // 1..5
  final String? comment;
  final DateTime createdAt;

  const PublicReview({
    required this.id,
    required this.deviceId,
    required this.productId,
    required this.branchId,
    this.productName,
    this.branchName,
    required this.productStars,
    required this.serviceStars,
    this.comment,
    required this.createdAt,
  });

  factory PublicReview.fromMap(Map<String, dynamic> map) {
    // Soporta select anidado de Supabase:
    // products(name) -> map['products']?['name']
    // branches(name) -> map['branches']?['name']
    final prodObj = map['products'] ?? map['product'];
    final branchObj = map['branches'] ?? map['branch'];

    return PublicReview(
      id: map['id'] as String,
      deviceId: map['device_id'] as String,
      productId: map['product_id'] as String,
      branchId: map['branch_id'] as String,
      productName: prodObj is Map<String, dynamic> ? prodObj['name'] as String? : null,
      branchName: branchObj is Map<String, dynamic> ? branchObj['name'] as String? : null,
      productStars: (map['product_stars'] as num).toInt(),
      serviceStars: (map['service_stars'] as num).toInt(),
      comment: (map['comment'] as String?)?.trim().isEmpty == true ? null : map['comment'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  @override
  List<Object?> get props => [id, productStars, serviceStars, comment, createdAt];
}