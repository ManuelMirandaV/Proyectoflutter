class Reaction {
  final int id;
  final String numero;

  const Reaction({
    required this.id,
    required this.numero,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'numero': String numero,
      } =>
        Reaction(id: id, numero: numero),
      _ => throw const FormatException('Fallo al cargar modelo'),
    };
  }
}
