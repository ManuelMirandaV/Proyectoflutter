import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto4/models/reaction.dart';

Future<List<Reaction>> fetchReactions() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/Reactions'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body
        .map((dynamic item) => Reaction.fromJson(item as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Fallo al cargar los comentarios');
  }
}

class Reactionlist extends StatefulWidget {
  const Reactionlist({Key? key}) : super(key: key);

  @override
  State<Reactionlist> createState() => _ReactionlistState();
}

class _ReactionlistState extends State<Reactionlist> {
  late Future<List<Reaction>> futureReactions;
  @override
  void initState() {
    super.initState();
    futureReactions = fetchReactions();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Obtener lista de datos',
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Reaction>>(
              future: futureReactions,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!
                        .map(
                          (Reaction) => Column(
                            children: <Widget>[
                              Text(Reaction.numero),
                              Text(Reaction.id.toString()),
                            ],
                          ),
                        )
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
