import 'dart:math';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import '../../../home/principalAdmin.dart';
import '../../../home/principalUsuarios.dart';
import '../../../servicios/auth.dart';
import '../../../utils/helper_functions.dart';
import '../components/register_screen.dart';
import '../../../utils/constants.dart';
import '../animations/change_screen_animation.dart';
import 'bottom_text.dart';
import 'top_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../LoginGoogle.dart';

enum Screens {
  createAccount,
  welcomeBack,
}

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
  Future<User?> _isCurrentSignIn(User user) async {
    if (user != null) {}
    //si no ha ido bien devolvemos null.
    return null;
  }

//signOutGoogle
  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut();

    print(", Usted a cerrado session.");
  }
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  bool loading = true;
  late TextEditingController _controller;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String error = '';
  User? user;
  FirebaseAuth authenticator = FirebaseAuth.instance;

  String usu = '';
  String pass = '';

  late final List<Widget> createAccountContent;
  late final List<Widget> loginContent;

  Widget inputField(String hint, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextField(
            controller: _emailController,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField2(String hint, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          inicioSesion(context, _emailController, _passwordController);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          primary: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget googleButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 20),
      child: MaterialButton(
        onPressed: () async {
          User? user = await Aunthenticator.iniciarSesion(context: context);
          print(user?.displayName);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => PrincipalAdmin()));
        },
        color: Colors.blue,
        child: Icon(FontAwesomeIcons.google),
        textColor: Colors.white,
      ),
    );
  }

  inicioSesion(BuildContext context, TextEditingController controladorNombre,
      TextEditingController controladorContrasena) async {
    loading = false;
    AuthService authService = AuthService();
    dynamic resultado = await authService.inicioSesionUarioContrasena(
        controladorNombre.text, controladorContrasena.text);
    print('Funcion iniciar sesion');

    if (controladorNombre.text.isEmpty || controladorNombre.text.isEmpty) {
      print("No deje campos vacios");
      setState(() {
        loading = true;
        error = "No deje campos vacios";
      });
    } else {
      if (controladorNombre.text.contains(' ') ||
          controladorContrasena.text.contains(' ')) {
        print("No ingrese espacios en blanco");
        setState(() {
          loading = true;
          error = "No ingrese espacios en blanco";
        });
      } else {
        if (resultado.toString().contains("Error")) {
          print("No se pudo iniciar sesión");
          setState(() {
            cajaAdvertencia(context, resultado.toString());
            loading = true;
            error = "No se pudo iniciar sesión";
          });
        } else {
          print(authService.usuarioDeFirebase(resultado)!.uid);
          if (authService.usuarioDeFirebase(resultado)!.uid ==
              "OigbJD7AQFcvIfjd6r0wBN2AuCK2") {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => PrincipalAdmin()));
          } else {
            print("No es administrador");
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => PrincipalUsuarios()));
          }
        }
      }
    }
  }

  registroSesion(BuildContext context, TextEditingController controladorNombre,
      TextEditingController controladorContrasena) async {
    loading = false;
    AuthService authService = AuthService();
    dynamic resultado = await authService.inicioSesionUarioContrasena(
        controladorNombre.text, controladorContrasena.text);
    print('Funcion para registrarse');

    if (controladorNombre.text.isEmpty || controladorNombre.text.isEmpty) {
      print("No deje campos vacios");
      setState(() {
        loading = true;
        error = "No deje campos vacios";
      });
    } else {
      if (controladorNombre.text.contains(' ') ||
          controladorContrasena.text.contains(' ')) {
        print("No ingrese espacios en blanco");
        setState(() {
          loading = true;
          error = "No ingrese espacios en blanco";
        });
      } else {
        if (resultado.toString().contains("Error")) {
          print("No se pudo registrar");
          setState(() {
            cajaAdvertencia(context, resultado.toString());
            loading = true;
            error = "No se pudo registrar";
          });
        } else {
          print(authService.usuarioDeFirebase(resultado)!.uid);
          if (authService.usuarioDeFirebase(resultado)!.uid ==
              "OigbJD7AQFcvIfjd6r0wBN2AuCK2") {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => PrincipalAdmin()));
          } else {
            print("No es administrador");
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => PrincipalUsuarios()));
          }
        }
      }
    }
  }

  cajaAdvertencia(BuildContext context, String msg) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Image.network(
              'https://www.lineex.es/wp-content/uploads/2018/06/alert-icon-red-11-1.png',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            const Text('  Advertencia ')
          ]),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.grey),
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
        print("Error en la autenticacion");
      }
    }
  }

  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'or',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget logos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/facebook.png'),
          const SizedBox(width: 24),
          Image.asset('assets/images/google.png'),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kSecondaryColor,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = TextEditingController();
    createAccountContent = [
      inputField('Email', Ionicons.mail_outline),
      inputField2('Password', Ionicons.lock_closed_outline),
      loginButton('Sign Up'),
      googleButton('Sign'),
      orDivider(),
      logos(),
    ];

    loginContent = [
      inputField('Email', Ionicons.mail_outline),
      inputField2('Password', Ionicons.lock_closed_outline),
      loginButton('Log In'),
      forgotPassword(),
    ];

    ChangeScreenAnimation.initialize(
      vsync: this,
      createAccountItems: createAccountContent.length,
      loginItems: loginContent.length,
    );

    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: createAccountContent[i],
      );
    }

    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    ChangeScreenAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 136,
          left: 24,
          child: TopText(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: createAccountContent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: loginContent,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: BottomText(),
          ),
        ),
      ],
    );
  }
}
