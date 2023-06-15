import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:visions/services/auth/auth_service.dart';
import 'package:visions/components/square_tile.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in with Google"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200),
            const SizedBox(
              child: Text(
                "Login with your Google account!",
              ),
            ),
            SquareTile(
              onTap: () => AuthService().signInWithGoogle(),
              imagePath: 'lib/images/google.png',
            ),
          ],
        ),
      ),
    );
  }
}
