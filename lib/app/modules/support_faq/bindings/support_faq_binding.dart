import 'package:get/get.dart';

import '../controllers/support_faq_controller.dart';

class SupportFaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportFaqController>(
      () => SupportFaqController(),
    );
  }
}
