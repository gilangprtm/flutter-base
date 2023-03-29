import 'package:get/get.dart';

import '../controllers/pasien_setup_controller.dart';

class PasienSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasienSetupController>(
      () => PasienSetupController(),
    );
  }
}
