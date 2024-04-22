import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/others/empty_component.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/mahas/services/mahas_format.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/mahas_service.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
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
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.toNotif();
                                    },
                                    child: SizedBox(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Stack(
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.solidBell,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Obx(() => Visibility(
                                                    visible: controller
                                                        .notifikasi.value,
                                                    child: const Icon(
                                                      Icons.circle,
                                                      size: 10,
                                                      color: Colors.red,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
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
                              // color: Colors.red,
                              child: Text(
                                "Selamat Datang ",
                                style: TextStyle(
                                  // fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              // color: Colors.red,
                              child: Text(
                                auth.currentUser!.displayName!,
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
                        () => Column(children: [
                          CarouselSlider(
                            items: controller.imageSlider(),
                            carouselController: controller.imageController,
                            options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 1.0,
                                onPageChanged: (index, reason) {
                                  controller.current.value = index;
                                }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: MahasConfig.coverImages
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
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(
                                              controller.current.value ==
                                                      entry.key
                                                  ? 0.9
                                                  : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        ]),
                      ),

                      // menu layanan
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Pilih Layanan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 90,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            width: 100,
                                            height: double.infinity,
                                            child: InkWell(
                                              onTap: (() => controller
                                                  .toDaftarRawatJalan()),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/daftar_rawat_jalan.png',
                                                    height: 40,
                                                    width: double.infinity,
                                                    fit: BoxFit.fitHeight,
                                                    color: MahasColors.primary,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "DAFTAR RAWAT JALAN",
                                                    style: MahasThemes.normal,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            width: 100,
                                            height: double.infinity,
                                            child: InkWell(
                                              onTap: () {
                                                controller.toUlasan();
                                              },
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/ulasan.png',
                                                    height: 40,
                                                    width: double.infinity,
                                                    fit: BoxFit.fitHeight,
                                                    color: MahasColors.primary,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "ULASAN",
                                                    style: MahasThemes.normal,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            width: 100,
                                            height: double.infinity,
                                            child: InkWell(
                                              onTap: () {
                                                controller.toRiwayat();
                                              },
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/riwayat_pendaftaran.png',
                                                    height: 40,
                                                    width: double.infinity,
                                                    fit: BoxFit.fitHeight,
                                                    color: MahasColors.primary,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "RIWAYAT PENDAFTARAN",
                                                    style: MahasThemes.normal,
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
                          ],
                        ),
                      ),
                      // berita
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          "Berita Terbaru",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                          height: Get.height,
                          child: Obx(
                            () => controller.artikels.isEmpty
                                ? EmptyComponent()
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      var item = controller.artikels[index];
                                      return InkWell(
                                        onTap: () =>
                                            controller.goToArticleDetail(item),
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MahasThemes.borderRadius),
                                              border: Border.all(
                                                  color: MahasColors.grey),
                                              color: MahasColors.light),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                MahasThemes.borderRadius),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  item.image ?? "",
                                                  fit: BoxFit.fill,
                                                  width: Get.width,
                                                  height: Get.width * 0.4,
                                                  loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) =>
                                                      loadingProgress != null
                                                          ? SizedBox(
                                                              width: Get.width,
                                                              height:
                                                                  Get.width *
                                                                      0.4,
                                                              child: Center(
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/iosloading.gif",
                                                                  width: 30,
                                                                  height: 30,
                                                                ),
                                                              ),
                                                            )
                                                          : child,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        MahasFormat.displayDate(
                                                          item.tanggal
                                                              ?.toDate(),
                                                        ),
                                                        style:
                                                            MahasThemes.mutedH3,
                                                      ),
                                                      Text(item.title ?? "",
                                                          style:
                                                              MahasThemes.h3),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: controller.artikels.length,
                                  ),
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
      ),
    );
  }
}
