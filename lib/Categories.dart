import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, required this.title});

  final String title;

  @override
  State<Categories> createState() => _Categories();
}

class _Categories extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
    );
  }
}
