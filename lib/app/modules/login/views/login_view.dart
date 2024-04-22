import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/constant/environment_constant.dart';
import 'package:haimed_getx/app/mahas/components/others/login_button.dart';

import '../../../mahas/mahas_colors.dart';
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
                  EnvironmentConstant.imageLogo,
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
                  const SizedBox(height: 10),
                  LoginButton(
                    onPressed: () => controller.googleLoginOnPress(),
                    type: LoginButtonType.google,
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: Platform.isIOS,
                    child: LoginButton(
                      onPressed: () => controller.appleLoginOnPress(),
                      type: LoginButtonType.apple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
