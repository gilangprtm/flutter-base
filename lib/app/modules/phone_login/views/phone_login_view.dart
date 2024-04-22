import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';
import '../controllers/phone_login_controller.dart';

class PhoneLoginView extends GetView<PhoneLoginController> {
  const PhoneLoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi'),
        centerTitle: false,
        backgroundColor: MahasColors.primary,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            children: [
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  controller.phoneCon.value = number.phoneNumber!;
                },
                initialValue: PhoneNumber(isoCode: "ID"),
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: MahasThemes.h1,
                hintText: "contoh: 8123456789",
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    MahasThemes.borderRadius,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MahasColors.primary,
                    ),
                    onPressed: () {
                      controller.signInOnTap();
                    },
                    child: const Text("KIRIM OTP")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
