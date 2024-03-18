class User {
  final int id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'user': String name,
        'email': String email,
      } =>
        User(id: id, name: name, email: email),
      _ => throw const FormatException('Fallo al cargar modelo'),
    };
  }
}
