class Branch {
  final String id; // Cambiado de int a String
  final String name;
  final String city;

  const Branch({
    required this.id,
    required this.name,
    required this.city,
  });

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      id: map['id'] as String,
      name: map['name'] as String,
      city: map['city'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
    };
  }
}