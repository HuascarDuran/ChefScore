class Product {
  final String id;
  final String name;
  final String imagePath;

  Product({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      imagePath: map['image_path'], // ya mapeado desde Supabase
    );
  }
}