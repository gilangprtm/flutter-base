import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/modules/home_premagana/controllers/home_premagana_controller.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/mahas_service.dart';

class HomePremaganaView extends GetView<HomePremaganaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MahasColors.primary,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: MahasColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // top
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      controller.toProfile();
                                    },
                                    child: Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.toSupport();
                                    },
                                    child: Icon(
                                      Icons.more_horiz,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                "Selamat Datang ",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                auth.currentUser?.displayName ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // carousel
                      Obx(
                        () => controller.imgList.isNotEmpty
                            ? Column(
                                children: [
                                  CarouselSlider(
                                    items: controller.imageSlider(),
                                    carouselController:
                                        controller.imageController,
                                    options: CarouselOptions(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.20,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        aspectRatio: 1.0,
                                        onPageChanged: (index, reason) {
                                          controller.current.value = index;
                                        }),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: controller.imgList
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                        onTap: () => controller.imageController
                                            .animateToPage(entry.key),
                                        child: Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black)
                                                  .withOpacity(controller
                                                              .current.value ==
                                                          entry.key
                                                      ? 0.9
                                                      : 0.4)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: MahasColors.primary,
                                  ),
                                ),
                              ),
                      ),

                      // menu layanan
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Text(
                          "Pilih Layanan",
                          style: MahasThemes.h2
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: MahasColors.dark
                                                .withOpacity(0.4),
                                            blurRadius: 5,
                                          ),
                                        ],
                                        color: MahasColors.light,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      width: Get.width,
                                      height: 80,
                                      child: InkWell(
                                        onTap: (() =>
                                            controller.toDaftarRawatJalan()),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/daftar_rawat_jalan.png',
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Reservasi Dokter",
                                              style: MahasThemes.h2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: MahasColors.dark
                                                .withOpacity(0.4),
                                            blurRadius: 5,
                                          ),
                                        ],
                                        color: MahasColors.light,
                                      ),
                                      width: Get.width,
                                      height: 80,
                                      child: InkWell(
                                        onTap: () {
                                          controller.toUlasan();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/ulasan.png',
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.fitHeight,
                                              color: MahasColors.primary,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Ulasan",
                                              style: MahasThemes.h2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: MahasColors.dark
                                                .withOpacity(0.4),
                                            blurRadius: 5,
                                          ),
                                        ],
                                        color: MahasColors.light,
                                      ),
                                      width: Get.width,
                                      height: 80,
                                      child: InkWell(
                                        onTap: () {
                                          controller.toRiwayat();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/riwayat_pendaftaran.png',
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Riwayat Pendaftaran",
                                              style: MahasThemes.h2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: MahasColors.dark
                                                .withOpacity(0.4),
                                            blurRadius: 5,
                                          ),
                                        ],
                                        color: MahasColors.light,
                                      ),
                                      width: Get.width,
                                      height: 80,
                                      child: InkWell(
                                        onTap: () {
                                          controller.toNotif();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: [
                                                Image.asset(
                                                  'assets/images/bell.png',
                                                  height: 45,
                                                  width: 45,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                                Obx(
                                                  () => Visibility(
                                                    visible: controller
                                                        .notifikasi.value,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25),
                                                      child: const Icon(
                                                        Icons.circle,
                                                        size: 15,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Notifikasi",
                                              style: MahasThemes.h2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //footer
                      Container(
                        width: Get.width,
                        margin: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: Column(
                          children: [
                            Divider(
                              thickness: 2.0,
                              color: MahasColors.primary,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => controller.launchWebsite(
                                      Uri.https(
                                          'instagram.com', '/rsu_premagana')),
                                  child: Image.asset(
                                    'assets/images/instagram.png',
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => controller.launchWebsite(
                                      Uri.https('rsupremagana.com')),
                                  child: Image.asset(
                                    'assets/images/website.png',
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.fitHeight,
                                    color: MahasColors.primary,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => controller.launchWebsite(
                                      Uri.https(
                                          'youtube.com', '/@rsupremagana4274')),
                                  child: Image.asset(
                                    'assets/images/youtube.png',
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => controller.launchWebsite(
                                    Uri(
                                      scheme: 'fb',
                                      host: 'profile',
                                      path: '/100012820276802',
                                    ),
                                  ),
                                  child: Image.asset(
                                    'assets/images/facebook.png',
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
