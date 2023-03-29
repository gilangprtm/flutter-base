import 'package:get/get.dart';

import '../controllers/tambah_pasien_controller.dart';

class TambahPasienBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahPasienController>(
      () => TambahPasienController(),
    );
  }
}
