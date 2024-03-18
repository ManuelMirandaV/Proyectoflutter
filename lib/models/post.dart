class Post {
  final int id;
  final String title;
  final String date;
  final int category_id;
  final String description;
  final int user_id;

  const Post({
    required this.id,
    required this.category_id,
    required this.title,
    required this.description,
    required this.user_id,
    required this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'date': String date,
        'category_id': int category_id,
        'description': String description,
        'user_id': int user_id,
      } =>
        Post(
            id: id,
            title: title,
            date: date,
            category_id: category_id,
            description: description,
            user_id: user_id),
      _ => throw const FormatException('Fallo al cargar modelo'),
    };
  }
}
