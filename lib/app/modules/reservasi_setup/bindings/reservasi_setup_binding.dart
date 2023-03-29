import 'package:get/get.dart';

import '../controllers/reservasi_setup_controller.dart';

class ReservasiSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReservasiSetupController>(
      () => ReservasiSetupController(),
    );
  }
}
