import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto4/screens/category/Categorylist.dart';

class AuthService {
  static Future<void> login(
      BuildContext context, String email, String password) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/login/');

    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final accessToken = responseData['access_token'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CategoryList()),
        );
      } else {
        final errorMessage = responseData['response'];
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error de inicio de sesión'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Faltan datos en el formulario'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
