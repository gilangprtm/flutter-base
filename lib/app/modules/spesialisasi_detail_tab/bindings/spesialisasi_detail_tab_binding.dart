import 'package:get/get.dart';

import '../controllers/spesialisasi_detail_tab_controller.dart';

class SpesialisasiDetailTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpesialisasiDetailTabController>(
      () => SpesialisasiDetailTabController(),
    );
  }
}
