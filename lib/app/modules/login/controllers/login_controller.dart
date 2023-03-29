import 'package:get/get.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

class LoginController extends GetxController {
  void toLogin() {
    Get.toNamed(Routes.REGISTER);
  }
}
