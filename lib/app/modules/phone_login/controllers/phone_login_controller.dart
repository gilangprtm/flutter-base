import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/services/http_api.dart';
import 'package:haimed_getx/app/modules/profile_setup/controllers/profile_setup_controller.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/services/helper.dart';
import '../../dokter_konfirmasi_tab/controllers/dokter_konfirmasi_tab_controller.dart';

class PhoneLoginController extends GetxController {
  RxString phoneCon = "".obs;
  RxString verId = ''.obs;
  RxString verify = ''.obs;
  RxString fromProfile = ''.obs;
  RxInt count = 0.obs;
  var auth = FirebaseAuth.instance;
  // var konfirmasi = Get.find<DokterKonfirmasiTabController>();
  late DokterKonfirmasiTabController? konfirmasi;
  late ProfileSetupController? profile;
  // var profile = Get.find<ProfileSetupController>();

  @override
  void onInit() async {
    fromProfile.value = Get.parameters['fromProfile'] ?? '';
    if (fromProfile.value == '') {
      konfirmasi = Get.isRegistered<DokterKonfirmasiTabController>()
          ? Get.find<DokterKonfirmasiTabController>()
          : Get.put(DokterKonfirmasiTabController());
    } else {
      profile = Get.isRegistered<ProfileSetupController>()
          ? Get.find<ProfileSetupController>()
          : Get.put(ProfileSetupController());
    }
    super.onInit();
  }

  Future<bool> bottomSheetBack() async {
    Helper.backOnPress();
    return true;
  }

  void countDown() {
    count.value = 60;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (count.value > 0) {
          count.value--;
        } else {
          timer.cancel();
        }
      },
    );
  }

  void signInOnTap() async {
    if (EasyLoading.isShow) {
      await EasyLoading.dismiss();
    }
    EasyLoading.show();
    if (phoneCon.value == "") {
      Helper.dialogWarning("field is required");
    } else {
      await verifyPhone(phoneCon.value);
      EasyLoading.dismiss();
      countDown();
      await showMaterialModalBottomSheet(
        expand: true,
        isDismissible: false,
        context: Get.context!,
        builder: (context) => WillPopScope(
          onWillPop: () => bottomSheetBack(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Konfirmasi"),
              centerTitle: false,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Kode OTP dikirim ke : ${phoneCon.value}",
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MahasThemes.borderRadius),
                      ),
                      child: TextButton(
                          onPressed: () {
                            Get.back(closeOverlays: true);
                          },
                          child: Text(
                            "Ganti Nomor HP",
                            style: MahasThemes.link,
                          )),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    OtpTextField(
                      numberOfFields: 6,
                      borderColor: MahasColors.primary,
                      focusedBorderColor: MahasColors.primary,
                      textStyle: MahasThemes.h1.copyWith(fontSize: 30),
                      showFieldAsBox: false,
                      borderWidth: 4.0,
                      onSubmit: (String verificationCode) {
                        verify.value = verificationCode;
                        otpOnTap();
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MahasThemes.borderRadius),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (count.value == 0) {
                            resendOTPOnTap();
                          }
                        },
                        child: Obx(
                          () => count.value == 0
                              ? Text(
                                  "Kirim Ulang OTP",
                                  style: MahasThemes.link,
                                )
                              : Text(
                                  "Kirim Ulang OTP (${count.value}) detik",
                                  style: MahasThemes.link,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    EasyLoading.dismiss();
  }

  void otpOnTap() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();
    await otpVerify(verify.value.toString());
    countDown();
    EasyLoading.dismiss();
  }

  void resendOTPOnTap() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();
    await verifyPhone(phoneCon.value);
    countDown();
    EasyLoading.dismiss();
  }

  //verifikasi no hp user untuk kirim OTP
  verifyPhone(String phone) async {
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 40),
      phoneNumber: phone,
      verificationCompleted: (AuthCredential authCredential) {
        if (auth.currentUser != null) {
          Helper.dialogSuccess("Anda sudah login!");
        }
      },
      verificationFailed: (authException) {
        if (authException.message!
            .contains((RegExp('expired', caseSensitive: false)))) {
          Helper.dialogWarning("Verifikasi recaptcha gagal!\nKode kadaluarsa");
        } else {
          Helper.dialogWarning(authException.message!);
        }
      },
      codeSent: (verificationId, forceResendingToken) {
        verId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String id) {
        verId.value = id;
      },
    );
  }

  //cek kode OTP untuk melanjutkan ke home
  otpVerify(String otp) async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();
    try {
      PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verId.value, smsCode: otp);
      if (fromProfile.value != '') {
        await auth.currentUser!.updatePhoneNumber(authCredential);
        profile!.telpCon.value = auth.currentUser!.phoneNumber;
        Get.back();
        Get.back();
      } else {
        if (auth.currentUser!.phoneNumber == null ||
            phoneCon.value != auth.currentUser!.phoneNumber) {
          auth.currentUser!.linkWithCredential(authCredential);
          try {
            var res = await HttpApi.put(
              '/api/User?user=${auth.currentUser!.uid}',
              body: {
                "UserIdHaimed": auth.currentUser!.uid,
                "Email": auth.currentUser!.email,
                "Nama": auth.currentUser!.displayName,
                "UrlGambar": auth.currentUser?.photoURL,
                "Telepon": phoneCon.value,
              },
            );
            if (res.success) {
              konfirmasi!.noHPCon.value ??= auth.currentUser!.phoneNumber;
              Get.back();
              Get.back();
            }
          } catch (e) {
            Helper.dialogWarning(e.toString());
          }
        } else {
          konfirmasi!.noHPCon.value ??= auth.currentUser!.phoneNumber;
          Get.back();
          Get.back();
        }
      }
    } catch (e) {
      Helper.dialogWarning("Kode OTP tidak sesuai!");
    }
    EasyLoading.dismiss();
  }
}
