import 'package:flutter/material.dart';

class Reactions extends StatefulWidget {
  const Reactions({super.key, required this.title});

  final String title;

  @override
  State<Reactions> createState() => _Reactions();
}

class _Reactions extends State<Reactions> {
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
                'Reactions',
              ),
            ],
          )
        ])));
  }
}
