import 'package:get/get.dart';

import '../controllers/dokter_detail_tab_controller.dart';

class DokterDetailTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DokterDetailTabController>(
      () => DokterDetailTabController(),
    );
  }
}
