import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  const Comments({super.key, required this.title});

  final String title;

  @override
  State<Comments> createState() => _Comments();
}

class _Comments extends State<Comments> {
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
                'Comments',
              ),
            ],
          )
        ])));
  }
}
