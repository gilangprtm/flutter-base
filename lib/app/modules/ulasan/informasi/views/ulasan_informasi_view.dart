import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/mahas/mahas_service.dart';

import '../../../../mahas_complement/coachmaker/coachmaker.dart';
import '../controllers/ulasan_informasi_controller.dart';

class UlasanInformasiView extends GetView<UlasanInformasiController> {
  final UlasanInformasiController c = Get.put(UlasanInformasiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      MahasConfig.currentEnv == MahasEnvironmentType.cendana
                          ? 'assets/images/logo-nobg.png'
                          : 'assets/images/logorsbk.png',
                      width: 80.0,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MahasConfig.informasiUmum.namars ?? "",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: MahasColors.primary,
                                size: 18,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Expanded(
                                child: Text(
                                  MahasConfig.informasiUmum.alamat ?? "",
                                  style: TextStyle(),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
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
              SizedBox(
                height: 10,
              ),

              // Reservasi
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reservasi",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Lakukan reservasi sekarang",
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              c.toReservasi();
                            },
                            child: CoachPoint(
                              initial: '1',
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: MahasColors.primary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.plus,
                                  color: MahasColors.light,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              // Informasi umum
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Informasi Umum",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: HtmlWidget(
                                  MahasConfig
                                          .informasiUmum.deskripsirumahsakit ??
                                      "",
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
              SizedBox(
                height: 10,
              ),

              // Kontak
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kontak Rumah Sakit",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.launchEmail(
                                      MahasConfig.informasiUmum.email ?? "");
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Email"),
                                          Text(
                                              MahasConfig.informasiUmum.email ??
                                                  ""),
                                        ],
                                      ),
                                      const Icon(
                                        FontAwesomeIcons.solidEnvelope,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 7,
                              ),
                              Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width - 60,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                              Divider(
                                height: 7,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.lauchPhoneCall(
                                      MahasConfig.informasiUmum.notelp ?? "");
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Telephone"),
                                          Text(MahasConfig
                                                  .informasiUmum.notelp ??
                                              ""),
                                        ],
                                      ),
                                      const Icon(
                                        FontAwesomeIcons.phone,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 7,
                              ),
                              Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width - 60,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                              Divider(
                                height: 7,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.launchWebsite(
                                    Uri.parse(
                                      MahasConfig.informasiUmum.website ?? "",
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Website"),
                                          Text(MahasConfig
                                                  .informasiUmum.website ??
                                              ""),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.web,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
