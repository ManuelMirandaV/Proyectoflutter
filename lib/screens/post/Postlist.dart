import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto4/models/post.dart';
import 'dart:convert';

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/Posts'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body
        .map((dynamic item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Fallo al cargar las publicaciones');
  }
}

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostlistState();
}

class _PostlistState extends State<PostList> {
  late Future<List<Post>> futurePost;
  @override
  void initState() {
    super.initState();
    futurePost = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Obtener lista de datos',
      home: Scaffold(
        body: Center(
          child: FutureBuilder<List<Post>>(
              future: futurePost,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!
                        .map(
                          (Post) => Column(
                            children: <Widget>[
                              Text(Post.title),
                              Text(Post.id.toString()),
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
