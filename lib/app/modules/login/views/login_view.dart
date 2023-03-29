import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/others/icon_button.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('LoginView'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.amber,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              SizedBox(
                height: 300,
                child: Image.asset(
                  "assets/images/haimedlogo.png",
                ),
              ),
              const SizedBox(height: 10),
              Spacer(),
              Column(
                children: [
                  Text(
                    "Melanjutkan dengan",
                    textAlign: TextAlign.center,
                    maxLines: 5,
                  ),
                  // const SizedBox(height: 10),
                  // Container(
                  //   height: 46,
                  //   width: 300,
                  //   child: ButtonWithIcon(
                  //     label: "Login menggunakan Email",
                  //     onTap: () {
                  //       controller.toLogin();
                  //     },
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Container(
                    height: 46,
                    width: 300,
                    child: ButtonWithIcon(
                      label: "Login menggunakan Google",
                      icon: Icon(FontAwesomeIcons.google),
                      // color: Colors.grey[800],
                      onTap: () {
                        controller.googleLoginOnPress();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
