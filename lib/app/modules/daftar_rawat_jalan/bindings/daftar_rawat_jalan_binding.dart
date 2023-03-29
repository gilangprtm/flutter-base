import 'package:get/get.dart';
import 'package:haimed_getx/app/modules/dokter_tab/controllers/dokter_tab_controller.dart';
import 'package:haimed_getx/app/modules/spesialisasi_tab/controllers/spesialisasi_tab_controller.dart';

import '../controllers/daftar_rawat_jalan_controller.dart';

class DaftarRawatJalanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarRawatJalanController>(
      () => DaftarRawatJalanController(),
    );
    Get.lazyPut<DokterTabController>(
      () => DokterTabController(),
    );
    Get.lazyPut<SpesialisasiTabController>(
      () => SpesialisasiTabController(),
    );
  }
}
