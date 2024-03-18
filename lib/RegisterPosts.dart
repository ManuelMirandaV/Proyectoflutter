import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'CRUD de Posts',
    home: PostListScreen(),
  ));
}

class Post {
  final int id;
  final String title;
  final String description;
  final String category;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
    );
  }
}

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late List<Post> _posts;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response = await http.get(Uri.parse('http://api/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        _posts = jsonData.map((data) => Post.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Posts')),
      body: _posts != null
          ? ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.category),
                  onTap: () {
                    // Navegar a la pantalla de detalles del post
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(post: post),
                      ),
                    );
                  },
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de creación de post
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostCreateScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PostDetailScreen extends StatelessWidget {
  final Post post;

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del Post')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título: ${post.title}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Descripción: ${post.description}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Categoría: ${post.category}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class PostCreateScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Post')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Categoría'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _createPost(context);
              },
              child: Text('Crear Post'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createPost(BuildContext context) async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final category = _categoryController.text;

    // Aquí debes hacer una solicitud HTTP POST a tu API para crear el post

    Navigator.pop(
        context); // Volver a la pantalla anterior después de crear el post
  }
}
