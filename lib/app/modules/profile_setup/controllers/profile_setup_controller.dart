import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/mahas_service.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../routes/app_pages.dart';

class ProfileSetupController extends GetxController {
  final namaCon = InputTextController();
  final telpCon = InputTextController(type: InputTextType.number);
  final storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();

  XFile? image;
  String? getImage;

  RxBool editable = true.obs;

  @override
  void onInit() {
    getImage = auth.currentUser!.photoURL;
    namaCon.value = auth.currentUser?.displayName;
    if (auth.currentUser!.phoneNumber != null) {
      telpCon.value = auth.currentUser!.phoneNumber;
      telpCon.onChanged = (value) => telpOnTap();
    } else {
      telpCon.onTap = () => telpOnTap();
    }
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
    image = await picker.pickImage(source: ImageSource.camera);
    update();
  }

  Future saveProfile() async {
    if (!namaCon.isValid) return false;
    if (!telpCon.isValid) return false;

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
          "Telepon": telpCon.value,
        },
      );
      if (res.success) {
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
      } else{
        bool error = MahasService.isInternetCausedError(res.message.toString());
        Helper.errorToast(message: !error ? res.message.toString() : null);
      }
    } catch (e) {
      Helper.errorToast(message: e.toString());
    }
    EasyLoading.dismiss();
  }
}
