import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class WelcomeController extends GetxController {
  final box = GetStorage();
  void onStarted() async {
    await box.write("new_install", false);
    Get.offAllNamed(Routes.LOGIN);
  }
}
