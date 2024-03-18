class Category {
  final int id;
  final String category;

  const Category({
    required this.id,
    required this.category,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'category': String category,
      } =>
        Category(id: id, category: category),
      _ => throw const FormatException('Fallo al cargar modelo'),
    };
  }
}
