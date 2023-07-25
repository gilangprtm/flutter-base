import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/models/profile_model.dart';
import '../../../mahas/mahas_config.dart';
import '../../../mahas/mahas_service.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  RxInt current = 0.obs;
  RxBool notifikasi = false.obs;
  final CarouselController imageController = CarouselController();
  String? token;

  final List<String> imgList = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
  ];

  @override
  void onInit() async {
    late final FirebaseMessaging messaging = FirebaseMessaging.instance;
    token = await messaging.getToken();
    await putUser();
    await getNotifikasi();
    super.onInit();
  }

  imageSlider() {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item,
                          fit: BoxFit.cover, width: double.infinity),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();

    return imageSliders;
  }

  void toLogin() {
    Get.toNamed(Routes.LOGIN);
  }

  void toProfile() {
    Get.toNamed(Routes.PROFILE)!.then((value) => {
          getNotifikasi(),
        });
  }

  void toDaftarRawatJalan() {
    Get.toNamed(Routes.DAFTAR_RAWAT_JALAN)!.then((value) => {
          getNotifikasi(),
        });
  }

  void goToArticleDetail() {
    Get.toNamed(Routes.ARTIKEL_DETAIL);
  }

  void toNotif() {
    Get.toNamed(Routes.NOTIFIKASI)!.then((value) => {
          getNotifikasi(),
        });
  }

  void toUlasan() {
    Get.toNamed(Routes.ULASAN_ULASANPAGE);
  }

  void toSupport() {
    Get.toNamed(Routes.SUPPORT);
  }

  void toRiwayat() {
    Get.toNamed(Routes.PASIEN);
  }

  Future getNotifikasi() async {
    try {
      var r =
          await HttpApi.get('/api/Notifikasi?userId=${auth.currentUser!.uid}');
      if (r.success) {
        Map<String, dynamic> data = json.decode(r.body);
        List list = data['Data'];
        var j = 0;
        for (var i = 0; i < list.length; i++) {
          if (list[i]['Dibaca'] == false) {
            notifikasi.value = true;
            j += 1;
          } else if (j == 0) {
            notifikasi.value = false;
          }
        }
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }
  }

  Future putUser() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();

    var r = await HttpApi.put('/api/User', body: {
      "UserIdHaimed": auth.currentUser!.uid.toString(),
      "Email": auth.currentUser!.email.toString(),
      "Nama": auth.currentUser!.displayName.toString(),
      "Fcm": token.toString(),
    });
    if (r.success) {
      MahasConfig.profile = ProfileModel.fromJson(r.body);
    } else {
      Helper.dialogWarning(r.message);
    }
    EasyLoading.dismiss();
  }
}
