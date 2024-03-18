import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto4/models/Reaction.dart';

Future<Reaction> fetchReaction() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/Reactions/12'));

  if (response.statusCode == 200) {
    return Reaction.fromJson(
        (jsonDecode(response.body) as Map<String, dynamic>));
  } else {
    throw Exception('Failed to load Reaction');
  }
}

class ReactionItem extends StatefulWidget {
  final int ReactionId;

  const ReactionItem({required this.ReactionId, Key? key}) : super(key: key);

  @override
  State<ReactionItem> createState() => _ReactionItemState();
}

class _ReactionItemState extends State<ReactionItem> {
  late Future<Reaction> futureReaction;

  @override
  void initState() {
    super.initState();
    futureReaction = fetchReaction();
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
                child: FutureBuilder<Reaction>(
                    future: futureReaction,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(snapshot.data!.numero),
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
