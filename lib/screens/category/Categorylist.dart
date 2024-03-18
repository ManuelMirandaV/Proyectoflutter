import 'package:flutter/material.dart';
import 'package:proyecto4/LoginPage.dart';
import 'package:proyecto4/RegisterPosts.dart';
import 'package:proyecto4/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';
import 'package:proyecto4/perfilpage.dart';
import 'package:proyecto4/screens/category/CategoryItem.dart';

Future<List<Category>> fetchCategories(String searchQuery) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/Categories'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Category> filteredCategories = body
        .map((dynamic item) => Category.fromJson(item as Map<String, dynamic>))
        .where((category) => category.category.contains(searchQuery))
        .toList();
    return filteredCategories;
  } else {
    throw Exception('Fallo al cargar las categorias');
  }
}

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late CancelableOperation<List<Category>>? fetchOperation;
  late String searchQuery = '';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchOperation = CancelableOperation.fromFuture(fetchCategories(''));
  }

  @override
  void dispose() {
    fetchOperation?.cancel();
    super.dispose();
  }

  void _handleSearchQuery(String value) {
    setState(() {
      searchQuery = value;
      fetchOperation?.cancel();
      fetchOperation =
          CancelableOperation.fromFuture(fetchCategories(searchQuery));
    });
  }

  void _onNavigationBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostCreateScreen()), //Aqui
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 109, 238, 126),
        title: const Text('Categorias'),
      ),
      backgroundColor: Color.fromARGB(122, 155, 226, 141),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                ),
                onChanged: _handleSearchQuery,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: fetchOperation!.value,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(snapshot.data!.length, (index) {
                        Category category = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryItem(id: category.id),
                              ),
                            );
                          },
                          child: Card(
                            color: Color.fromARGB(255, 109, 238, 126),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(category.category),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavigationBarItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Publicar',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 108, 243, 108),
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
                title: Text('Perfil'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PerfilPage(
                                title: '',
                              )));
                }),
            ListTile(
              title: Text('Cerrar Sesión'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Login(
                              title: 'Noticias',
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
