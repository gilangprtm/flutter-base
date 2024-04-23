import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/constant/environment_constant.dart';

import '../../../mahas/components/others/no_internet_component.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isError.value
            ? NoInternetConnectionPage(
                onPressed: controller.refreshData,
              )
            : Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          EnvironmentConstant.imageSplash,
                          scale: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
