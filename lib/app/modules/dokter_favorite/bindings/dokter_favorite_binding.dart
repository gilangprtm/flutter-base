import 'package:get/get.dart';

import '../controllers/dokter_favorite_controller.dart';

class DokterFavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DokterFavoriteController>(
      () => DokterFavoriteController(),
    );
  }
}
