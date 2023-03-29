import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  RxInt current = 0.obs;
  final CarouselController imageController = CarouselController();

  final List<String> imgList = [
    'assets/images/ilustrasi.jpeg',
    'assets/images/ilustrasi.jpeg',
    'assets/images/ilustrasi.jpeg',
    'assets/images/ilustrasi.jpeg',
  ];

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
    Get.toNamed(Routes.PROFILE);
  }

  void toDaftarRawatJalan() {
    Get.toNamed(Routes.DAFTAR_RAWAT_JALAN);
  }

  void goToArticleDetail() {
    Get.toNamed(Routes.ARTIKEL_DETAIL);
  }

  void toNotif() {
    Get.toNamed(Routes.NOTIFIKASI);
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
}
