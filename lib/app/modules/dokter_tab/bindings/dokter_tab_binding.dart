import 'package:get/get.dart';

import '../controllers/dokter_tab_controller.dart';

class DokterTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DokterTabController>(
      () => DokterTabController(),
    );
  }
}
