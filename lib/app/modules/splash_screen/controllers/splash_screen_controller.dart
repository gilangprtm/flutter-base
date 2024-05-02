import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../mahas/mahas_service.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController instance =
      Get.isRegistered<SplashScreenController>()
          ? Get.find<SplashScreenController>()
          : Get.put(SplashScreenController());

  RxBool isError = false.obs;
  void refreshData() async {
    await EasyLoading.show();
    await MahasService.checkFirebase(isInit: true);
    await EasyLoading.dismiss();
  }
}
