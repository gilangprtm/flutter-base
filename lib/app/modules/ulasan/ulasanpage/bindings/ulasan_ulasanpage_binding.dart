import 'package:get/get.dart';

import '../controllers/ulasan_ulasanpage_controller.dart';

class UlasanUlasanpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UlasanUlasanpageController>(
      () => UlasanUlasanpageController(),
    );
  }
}
