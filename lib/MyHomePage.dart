import 'package:flutter/material.dart';
import 'package:proyecto4/screens/category/Categorylist.dart';
import 'package:proyecto4/screens/comment/Commentlist.dart';
import 'package:proyecto4/screens/post/Postlist.dart';
import 'package:proyecto4/screens/reaction/Reactionlist.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Reactionlist()),
              );
            },
            child: Container(
              height: 50,
              color: Colors.blue[500],
              child: const Center(child: Text('Reactions')),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Commentlist()),
              );
            },
            child: Container(
              height: 50,
              color: Color.fromARGB(255, 211, 13, 46),
              child: const Center(child: Text('Comments')),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PostList()),
              );
            },
            child: Container(
              height: 50,
              color: Color.fromARGB(255, 15, 209, 15),
              child: const Center(child: Text('Posts')),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryList()),
              );
            },
            child: Container(
              height: 50,
              color: const Color.fromARGB(255, 3, 34, 59),
              child: const Center(child: Text('categorias')),
            ),
          ),
        ],
      ),
    );
  }
}
