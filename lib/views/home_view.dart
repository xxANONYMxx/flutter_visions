import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:visions/constants/routs.dart';
import 'package:visions/services/auth/auth_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: showWidget(context),
    );
  }

  showWidget(BuildContext context){
    if(false){
      print("You are loged in");
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            pictureRoute, (route) => false);
      });
    } else {
      print("You are not loged in");
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
      });
    }
  }
}
