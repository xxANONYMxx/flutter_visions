import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:visions/constants/routs.dart';
import 'package:visions/firebase_options.dart';
import 'package:visions/views/auth_view.dart';
import 'package:visions/views/home_view.dart';
import 'package:visions/views/login_view.dart';
import 'package:visions/views/picture_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({super.key, required this.camera});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthView(camera:camera),
      routes: {
        loginRoute: (context)=>const LoginView(),
        pictureRoute: (context)=> PictureView(camera:camera),
        homeRoute: (context)=>const HomeView(),
      },
    );
  }
}