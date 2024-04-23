import 'package:get/get.dart';

import '../controllers/home_premagana_controller.dart';

class HomePremaganaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePremaganaController>(
      () => HomePremaganaController(),
    );
  }
}
