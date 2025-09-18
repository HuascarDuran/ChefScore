class Order {
  final String id;
  final DateTime createdAt;
  final List<String> items;
  final bool reviewed; // true si ya tiene reseña asociada

  Order({
    required this.id,
    required this.createdAt,
    required this.items,
    this.reviewed = false,
  });

  Order markReviewed() => Order(
    id: id, createdAt: createdAt, items: items, reviewed: true,
  );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json['id'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    items: (json['items'] as List).map((e) => e.toString()).toList(),
    reviewed: json['reviewed'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'items': items,
    'reviewed': reviewed,
  };
}
