import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto4/models/comment.dart';

Future<List<Comment>> fetchComments() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/Comments'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body
        .map((dynamic item) => Comment.fromJson(item as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Fallo al cargar los comentarios');
  }
}

class Commentlist extends StatefulWidget {
  const Commentlist({Key? key}) : super(key: key);

  @override
  State<Commentlist> createState() => _CommentlistState();
}

class _CommentlistState extends State<Commentlist> {
  late Future<List<Comment>> futureComments;
  @override
  void initState() {
    super.initState();
    futureComments = fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Obtener lista de datos',
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Comment>>(
              future: futureComments,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!
                        .map(
                          (comment) => Column(
                            children: <Widget>[
                              Text(comment.comment),
                              Text(comment.id.toString()),
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
