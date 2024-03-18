import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key, required this.title});

  final String title;

  @override
  State<Posts> createState() => _Posts();
}

class _Posts extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const Center(
            child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Posts',
              ),
            ],
          )
        ])));
  }
}
