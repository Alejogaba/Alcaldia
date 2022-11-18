import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen/components/login_content.dart';
import '../screens/login_screen/login_screen.dart';

class PrincipalUsuarios extends StatefulWidget {
  const PrincipalUsuarios({Key? key}) : super(key: key);

  @override
  _PrincipalUsuariosState createState() => _PrincipalUsuariosState();
}

class _PrincipalUsuariosState extends State<PrincipalUsuarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal Usuarios'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
          color: Colors.blue,
          child: Icon(Icons.logout),
          textColor: Colors.white,
        ),
      ),
    );
  }
}
