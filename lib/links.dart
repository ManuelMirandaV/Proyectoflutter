import 'package:flutter/material.dart';

class Links extends StatefulWidget {
  const Links({super.key, required this.title});

  final String title;

  @override
  State<Links> createState() => _Links();
}

class _Links extends State<Links> {
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
                'Links',
              ),
            ],
          )
        ])));
  }
}
