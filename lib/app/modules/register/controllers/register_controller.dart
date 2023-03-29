import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_text_component.dart';

class RegisterController extends GetxController {
  final emailCon = InputTextController(
    type: InputTextType.email,
  );
  final passCon = InputTextController(
    type: InputTextType.password,
  );
  final namaCon = InputTextController();

  RxBool isLogin = true.obs;

  void onLogin() {
    isLogin.value = !isLogin.value;
  }
}
