import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/others/shimmer_component.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';
import '../controllers/profile_setup_controller.dart';

class ProfileSetupView extends GetView<ProfileSetupController> {
  const ProfileSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: false,
        backgroundColor: MahasColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => controller.loadingData.value
                ? const ShimmerComponent()
                : Column(
                    children: [
                      GetBuilder<ProfileSetupController>(
                        builder: (c) => Column(
                          children: [
                            c.editable.isFalse
                                ? Container(
                                    width: Get.width,
                                    height: Get.width * 0.8,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: MahasColors.grey.withOpacity(0.06),
                                      borderRadius: BorderRadius.circular(
                                          MahasThemes.borderRadius),
                                    ),
                                    child: c.getImage == null
                                        ? Center(
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    "assets/images/no-photo.png",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Image.network(c.getImage!),
                                  )
                                : Container(
                                    width: Get.width,
                                    height: Get.width * 0.8,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: MahasColors.grey.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(
                                          MahasThemes.borderRadius),
                                    ),
                                    child: c.getImage == null && c.image == null
                                        ? Center(
                                            child: SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: CircularProgressIndicator(
                                                color: MahasColors.primary,
                                              ),
                                            ),
                                          )
                                        : c.getImage != null && c.image == null
                                            ? Image.network(c.getImage!)
                                            : c.getImage != null &&
                                                    c.image != null
                                                ? Image.file(
                                                    File(c.image!.path),
                                                  )
                                                : Center(
                                                    child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                            "assets/images/no-photo.png",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                  ),
                            c.editable.isTrue
                                ? Column(
                                    children: [
                                      SizedBox(
                                        width: Get.width,
                                        height: 35,
                                        child: TextButton(
                                          onPressed: () {
                                            c.fromGallery();
                                          },
                                          child: Text(
                                            "From Gallery",
                                            style: MahasThemes.link
                                                .copyWith(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width,
                                        height: 35,
                                        child: TextButton(
                                          onPressed: () {
                                            c.fromCamera();
                                          },
                                          child: Text(
                                            "From Camera",
                                            style: MahasThemes.link
                                                .copyWith(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputTextComponent(
                        label: "Nama Lengkap",
                        required: true,
                        editable: controller.editable.value,
                        controller: controller.namaCon,
                      ),
                      InternationalPhoneNumberInput(
                        isEnabled: controller.editable.value,
                        onInputChanged: (PhoneNumber number) async {
                          try {
                            if (number.phoneNumber != null &&
                                number.phoneNumber!.isNotEmpty) {
                              controller.phoneNumber.value = await PhoneNumber
                                  .getRegionInfoFromPhoneNumber(
                                      number.phoneNumber!);
                              controller.validatorText.value = "";
                            }
                          } on PlatformException catch (e) {
                            controller.validatorText.value =
                                e.message.toString();
                          } catch (e) {
                            controller.validatorText.value = e.toString();
                          }
                        },
                        textFieldController: controller.telpCon,
                        initialValue: controller.phoneNumber.value,
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        key: controller.formKey,
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.always,
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
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            controller.phoneIsValid.value = false;
                            return controller.validatorText.value;
                          } else if (controller.validatorText.value != "") {
                            controller.phoneIsValid.value = false;
                            return controller.validatorText.value;
                          }
                          controller.phoneIsValid.value = true;
                          return null;
                        },
                        onInputValidated: (value) =>
                            controller.phoneIsValid.value = value,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: controller.editable.value,
                        child: Container(
                          width: Get.width,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.saveProfile();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MahasColors.primary,
                            ),
                            child: Text(
                              "SIMPAN",
                              style: MahasThemes.h3White,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
