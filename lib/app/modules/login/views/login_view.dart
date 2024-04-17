import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/others/icon_button.dart';

import '../../../mahas/mahas_colors.dart';
import '../../../mahas/mahas_config.dart';
import '../../../mahas/mahas_service.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MahasColors.primary,
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
                  MahasConfig.currentEnv == MahasEnvironmentType.cendana
                      ? "assets/images/logo-nobg.png"
                      : "assets/images/logorsbk.png",
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
