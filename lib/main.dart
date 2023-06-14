import 'package:camera/camera.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visions/constants/credentials.dart';
import 'package:visions/constants/routs.dart';
import 'package:visions/firebase_options.dart';
import 'package:visions/views/auth_view.dart';
import 'package:visions/views/gallery_view.dart';
import 'package:visions/views/login_view.dart';
import 'package:visions/views/picture_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  CloudinaryContext.cloudinary =
      Cloudinary.fromCloudName(cloudName: CloudName, apiKey: ApiKey);

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
        galleryRoute: (context)=> const GalleryView(),
      },
    );
  }
}