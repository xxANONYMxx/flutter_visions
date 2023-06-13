import 'package:firebase_auth/firebase_auth.dart';
import 'package:visions/constants/routs.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:visions/services/auth/auth_service.dart';
import 'package:visions/square_tile.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(
            title: const Text("Sign in with Google")
        ),
        body: SquareTile(
          onTap: () =>  AuthService().signInWithGoogle(),
          imagePath: 'lib/images/google.png',
        )
    );
  }
}