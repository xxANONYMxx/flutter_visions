import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visions/constants/routs.dart';
import 'package:visions/views/login_view.dart';
import 'package:visions/views/picture_view.dart';

class AuthView extends StatelessWidget {
  final CameraDescription camera;
  const AuthView({Key? key, required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in
          if(snapshot.hasData) return PictureView(camera: camera);
          //user not logged in
          else return LoginView();
        },
      ),
    );
  }
}
