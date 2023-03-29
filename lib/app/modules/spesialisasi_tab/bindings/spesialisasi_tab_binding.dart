import 'package:get/get.dart';

import '../controllers/spesialisasi_tab_controller.dart';

class SpesialisasiTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpesialisasiTabController>(
      () => SpesialisasiTabController(),
    );
  }
}
