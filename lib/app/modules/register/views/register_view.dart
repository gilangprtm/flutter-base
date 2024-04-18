import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';

import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/mahas_themes.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() =>
            controller.isLogin.value == false ? Text('Daftar') : Text('Login')),
        centerTitle: true,
        backgroundColor: MahasColors.primary,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            InputTextComponent(
              label: "Email",
              controller: controller.emailCon,
            ),
            Obx(() => Visibility(
                  visible: controller.isLogin.value == false,
                  child: InputTextComponent(
                    label: "Nama Depan dan Belakang",
                    controller: controller.namaCon,
                  ),
                )),
            Obx(() => Visibility(
                  visible: controller.isLogin.value == false,
                  child: InputTextComponent(
                    label: "Password",
                    controller: controller.passCon,
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MahasColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(MahasThemes.borderRadius)),
                      ),
                    ),
                    onPressed: () {
                      controller.onLogin();
                    },
                    child: Obx(() => controller.isLogin.value == false
                        ? Text('Simpan')
                        : Text('Lanjutkan')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
