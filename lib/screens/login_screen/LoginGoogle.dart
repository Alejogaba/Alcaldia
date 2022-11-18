import 'dart:developer';
import '../login_screen/components/login_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class Aunthenticator {

  static Future<User?> iniciarSesion({required BuildContext context}) async {
    FirebaseAuth authenticator = FirebaseAuth.instance;
    User? user;

    GoogleSignIn objGoogleSingnIn = GoogleSignIn();
    GoogleSignInAccount? objGoogleSignInAccount =
        await objGoogleSingnIn.signIn();

    if (objGoogleSignInAccount != null) {
      GoogleSignInAuthentication objGoogleSignInAuthentication =
          await objGoogleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: objGoogleSignInAuthentication.accessToken,
          idToken: objGoogleSignInAuthentication.idToken);
      try {
        UserCredential userCredential =
            await authenticator.signInWithCredential(credential);
        user = userCredential.user; 
        return user;
      } on FirebaseAuthException catch (e) {
        log("Error en la autenticacion");
      }
    }
  }
}


