import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto4/models/post.dart';
import 'package:proyecto4/screens/category/Categorylist.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key, required this.id});
  final int id;
  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  late Future<List<Post>> futureCategory;

  @override
  void initState() {
    super.initState();
    futureCategory = fetchCategory();
  }

  Future<List<Post>> fetchCategory() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/Categories/${widget.id}/Posts'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Fallo al cargar la categoria');
    }
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Categoria',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 170, 235, 179),
        ),
      ),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 170, 235, 179),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 109, 238, 126),
          title: Text('Categoria'),
        ),
        body: Center(
          child: FutureBuilder<List<Post>>(
            future: futureCategory,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Post category = snapshot.data![index];

                    return Column(
                      children: [
                        Container(
                          color: Color.fromARGB(255, 218, 218, 218),
                          child: Card(
                            margin: EdgeInsets.all(8.0),
                            color: Color.fromARGB(255, 195, 240, 202),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    category.title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(category.description),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.thumb_up),
                                          onPressed: () {
                                            // Acción cuando se presiona el botón de "Me Gusta"
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.comment),
                                          onPressed: () {
                                            // Acción cuando se presiona el botón de comentar
                                          },
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 150)),
                                        Text(category.date),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CategoryList()),
              );
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Ajustes',
            ),
          ],
        ),
      ),
    );
  }
}
