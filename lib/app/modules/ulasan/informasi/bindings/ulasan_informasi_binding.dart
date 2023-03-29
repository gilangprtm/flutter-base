import 'package:get/get.dart';

import '../controllers/ulasan_informasi_controller.dart';

class UlasanInformasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UlasanInformasiController>(
      () => UlasanInformasiController(),
    );
  }
}
