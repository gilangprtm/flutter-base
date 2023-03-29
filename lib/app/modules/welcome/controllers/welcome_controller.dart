import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class WelcomeController extends GetxController {
  void onStarted() {
    Get.offAllNamed(Routes.home);
  }

  void onSkip() {
    Get.toNamed(Routes.LOGIN);
  }
}
