import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/models/profile_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/mahas_service.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../routes/app_pages.dart';

class ProfileSetupController extends GetxController {
  final namaCon = InputTextController();
  final telpCon = TextEditingController();
  final storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  Rx<PhoneNumber> phoneNumber = PhoneNumber(isoCode: "ID").obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool phoneIsValid = false.obs;
  RxString validatorText = "The field is required".obs;
  RxBool loadingData = false.obs;

  XFile? image;
  String? getImage;

  RxBool editable = true.obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  void telpOnTap() {
    Get.toNamed(Routes.PHONE_LOGIN,
        parameters: {"fromProfile": true.toString()});
  }

  void fromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  void fromCamera() async {
    image = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
    update();
  }

  Future<void> getProfile() async {
    loadingData.value = true;
    getImage = auth.currentUser!.photoURL;
    namaCon.value = auth.currentUser?.displayName;
    if (MahasConfig.profile != null &&
        MahasConfig.profile!.telepon != null &&
        MahasConfig.profile!.telepon!.isNotEmpty) {
      PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(
          MahasConfig.profile!.telepon!);
      phoneNumber.value = number;
    }
    validatorText.value = "";
    phoneIsValid.value = true;
    loadingData.value = false;
  }

  Future saveProfile() async {
    if (!namaCon.isValid) return false;
    if (!phoneIsValid.value) return false;

    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();
    try {
      var res = await HttpApi.put(
        '/api/User?user=${auth.currentUser!.uid}',
        body: {
          "UserIdHaimed": auth.currentUser!.uid,
          "Email": auth.currentUser!.email,
          "Nama": namaCon.value,
          "UrlGambar": auth.currentUser?.photoURL,
          "Telepon": phoneNumber.value.phoneNumber,
        },
      );
      if (res.success) {
        MahasConfig.profile = ProfileModel.fromJson(res.body);
        await auth.currentUser!.updateDisplayName(namaCon.value);
        if (image != null) {
          String ext = image!.name.split(".").last;
          await storage
              .ref(auth.currentUser!.uid)
              .child("profile.$ext")
              .putFile(File(image!.path));
          getImage = await storage
              .ref(auth.currentUser!.uid)
              .child("profile.$ext")
              .getDownloadURL();
          await auth.currentUser!.updatePhotoURL(getImage);
        }
        editable.value = false;
      } else {
        bool error = MahasService.isInternetCausedError(res.message.toString());
        Helper.errorToast(message: !error ? res.message.toString() : null);
      }
    } catch (e) {
      Helper.errorToast(message: e.toString());
    }
    EasyLoading.dismiss();
  }
}
