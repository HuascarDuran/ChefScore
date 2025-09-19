class PublicReview {
  final int id;
  final String productName;
  final String branchName;
  final int stars;
  final String comment;
  final DateTime createdAt;

  const PublicReview({
    required this.id,
    required this.productName,
    required this.branchName,
    required this.stars,
    required this.comment,
    required this.createdAt,
  });

  /// Factory que espera claves en snake_case tal como vienen de Supabase/Postgres
  /// (por ejemplo en una view/RPC que ya incluye `product_name` y `branch_name`).
  factory PublicReview.fromJson(Map<String, dynamic> json) {
    return PublicReview(
      id: json['id'] as int,
      productName: (json['product_name'] ?? json['productName']) as String,
      branchName: (json['branch_name'] ?? json['branchName']) as String,
      stars: json['stars'] as int,
      comment: (json['comment'] as String?) ?? '',
      createdAt: _parseDate(json['created_at'] ?? json['createdAt']),
    );
  }

  /// Factory compatible con mapas en camelCase (por ejemplo, DTOs internos).
  factory PublicReview.fromMap(Map<String, dynamic> map) {
    return PublicReview(
      id: map['id'] as int,
      productName: (map['productName'] ?? map['product_name']) as String,
      branchName: (map['branchName'] ?? map['branch_name']) as String,
      stars: map['stars'] as int,
      comment: (map['comment'] as String?) ?? '',
      createdAt: _parseDate(map['createdAt'] ?? map['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'branch_name': branchName,
      'stars': stars,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'branchName': branchName,
      'stars': stars,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

DateTime _parseDate(Object? v) {
  if (v is DateTime) return v;
  if (v is String) return DateTime.parse(v);
  throw ArgumentError('Fecha inválida: $v');
}