import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
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
                  decoration:  BoxDecoration(
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
                            children:
                                MahasConfig.coverImages.asMap().entries.map((entry) {
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
                        padding: const EdgeInsets.all(10.0),
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
                                      height: 100,
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
                                                    height: 50,
                                                    width: double.infinity,
                                                    fit: BoxFit.fitHeight,
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
                                                    height: 50,
                                                    width: double.infinity,
                                                    fit: BoxFit.fitHeight,
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
                                                    height: 50,
                                                    width: double.infinity,
                                                    fit: BoxFit.fitHeight,
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
                                    // Divider(
                                    //   color: MahasColors.primary,
                                    //   thickness: 2,
                                    //   height: 10,
                                    // ),
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
                          child: ListView.builder(
                            itemBuilder: ((context, index) => InkWell(
                                  onTap: () => controller.goToArticleDetail(),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MahasThemes.borderRadius),
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
                                          Image.asset(
                                            'assets/images/ilustrasi.jpeg',
                                            fit: BoxFit.fill,
                                            width: Get.width,
                                            height: Get.width * 0.4,
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  MahasFormat.displayDate(
                                                      DateTime.now()),
                                                  style: MahasThemes.mutedH3,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                                  style: MahasThemes.mutedH3,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            itemCount: 5,
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
