import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto4/models/comment.dart';

Future<Comment> fetchComment() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/Comments/12'));

  if (response.statusCode == 200) {
    return Comment.fromJson(
        (jsonDecode(response.body) as Map<String, dynamic>));
  } else {
    throw Exception('Fallo al cargar el comentario');
  }
}

class CommentItem extends StatefulWidget {
  final int commentId;

  const CommentItem({required this.commentId, Key? key}) : super(key: key);

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  late Future<Comment> futureComment;

  @override
  void initState() {
    super.initState();
    futureComment = fetchComment();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Obtener Datos',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Obtener Datos'),
            ),
            body: Center(
                child: FutureBuilder<Comment>(
                    future: futureComment,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(snapshot.data!.comment),
                            Text(snapshot.data!.id.toString())
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }))));
  }
}
