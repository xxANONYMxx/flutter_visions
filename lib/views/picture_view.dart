import 'package:camera/camera.dart';
import 'package:cloudinary_url_gen/transformation/effect/effect.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:visions/constants/routs.dart';

import '../constants/credentials.dart';

class PictureView extends StatefulWidget {
  final CameraDescription camera;

  const PictureView({Key? key, required this.camera}) : super(key: key);

  @override
  State<PictureView> createState() => _PictureViewState();
}

enum MenuAction { logout }

class _PictureViewState extends State<PictureView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  Future<bool> showLogoutDialog(BuildContext context) {
    return showDialog<bool>(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Sign out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Cancle"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Log out"),
          ),
        ],
      );
    }).then((value) => value ?? false);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.camera);
    return Scaffold(
      appBar: AppBar(
          title: Text("Take a picture"),
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              print(value.toString());
              switch(value){
                case MenuAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  if(shouldLogout){
                    await FirebaseAuth.instance.signOut();
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                    value: MenuAction.logout, child: Text("Logout"))
              ];
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: 50,
                child: Center(child: Text("Logged in as " + user.email!))),
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return CameraPreview(_controller);
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            TextButton(onPressed: () => {Navigator.pushNamed(context, galleryRoute)}, child: Text("Gallery")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;
            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            // CloudinaryContext.cloudinary.uploader().upload(image);
            Cloudinary cloudinary = Cloudinary.signedConfig(
              apiKey: ApiKey,
              apiSecret: ApiSecret,
              cloudName: CloudName,
            );

            cloudinary.upload(fileBytes: await image.readAsBytes(), folder: 'flutter_cloudinary');
            
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
