import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.judul),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
