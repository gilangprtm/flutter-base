import 'package:get/get.dart';

import '../controllers/detail_reservasi_controller.dart';

class DetailReservasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailReservasiController>(
      () => DetailReservasiController(),
    );
  }
}
