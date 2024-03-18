class Comment {
  final int id;
  final String comment;
  final int user_id;
  final String date;
  final int reaction_id;

  const Comment({
    required this.id,
    required this.comment,
    required this.date,
    required this.user_id,
    required this.reaction_id,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'comment': String comment,
        'reaction_id': int reaction_id,
        'user': int user_id,
        'date': String date,
      } =>
        Comment(
            id: id,
            comment: comment,
            user_id: user_id,
            date: date,
            reaction_id: reaction_id),
      _ => throw const FormatException('Fallo al cargar modelo'),
    };
  }
}
