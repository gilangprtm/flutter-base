import 'package:get/get.dart';

import '../controllers/dokter_konfirmasi_tab_controller.dart';

class DokterKonfirmasiTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DokterKonfirmasiTabController>(
      () => DokterKonfirmasiTabController(),
    );
  }
}
