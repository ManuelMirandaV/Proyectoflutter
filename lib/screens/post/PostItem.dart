import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto4/models/post.dart';

Future<Post> fetchPost() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/Post/12'));

  if (response.statusCode == 200) {
    return Post.fromJson((jsonDecode(response.body) as Map<String, dynamic>));
  } else {
    throw Exception('Fallo al cargar las publicaciones');
  }
}

class PostItem extends StatefulWidget {
  final int postId;

  const PostItem({required this.postId, Key? key}) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  late Future<Post> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
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
                child: FutureBuilder<Post>(
                    future: futurePost,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(snapshot.data!.title),
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
