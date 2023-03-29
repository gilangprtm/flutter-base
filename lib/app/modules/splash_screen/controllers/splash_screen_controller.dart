import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  String judul = "";
  @override
  void onInit() async {
    await Future.delayed(Duration(seconds: 2));
    Get.offAllNamed(Routes.home);

    super.onInit();
  }
}
