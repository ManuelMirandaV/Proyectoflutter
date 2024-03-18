import 'package:flutter/material.dart';

import 'package:proyecto4/AuthService.dart';
import 'package:proyecto4/Registeruser.dart';

class Login extends StatelessWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _PasswordController = TextEditingController();
 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 109, 238, 126),
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(10),
              child: Image(
                image: AssetImage('NOTI.png'),
                width: 150,
                height: 150,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _PasswordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                AuthService.login(
                    context, _emailController.text, _PasswordController.text);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(92, 238, 7, 0.51),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ingresar",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No tienes cuenta?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginRegister(
                                title: '',
                              )),
                    );
                  },
                  child: Text(
                    'Registrarse',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 109, 238, 126),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
