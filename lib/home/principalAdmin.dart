import 'package:AlcaldiaServices/screens/login_screen/components/TextApp.dart';
import 'package:AlcaldiaServices/screens/login_screen/components/login_content.dart';
import 'package:AlcaldiaServices/screens/login_screen/components/top_text.dart';
import 'package:AlcaldiaServices/screens/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/login_screen/LoginGoogle.dart';
import 'package:AlcaldiaServices/screens/login_screen/components/login_content.dart';

class PrincipalAdmin extends StatefulWidget {
  const PrincipalAdmin({Key? key}) : super(key: key);

  @override
  _PrincipalAdminState createState() => _PrincipalAdminState();
}

class _PrincipalAdminState extends State<PrincipalAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal Admin'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            LoginContent().signOutGoogle();
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
