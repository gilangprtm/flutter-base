import 'package:get/get.dart';

import '../controllers/ulasan_ulasan_controller.dart';

class UlasanUlasanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UlasanUlasanController>(
      () => UlasanUlasanController(),
    );
  }
}
