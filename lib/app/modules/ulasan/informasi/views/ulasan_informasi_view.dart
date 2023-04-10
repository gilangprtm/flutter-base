import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';

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
              // Rs bhayangkara
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
                      'assets/images/logo.png',
                      width: 80.0,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "RS. Cendana Premier",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: MahasColors.primary,
                              size: 18,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Container(
                              // width: 240,
                              width: MediaQuery.of(context).size.width - 180,
                              child: Text(
                                "Jl. Cok Rai Pudak, Peliatan, Kecamatan Ubud, Kabupaten Gianyar, Bali 80571",
                                style: TextStyle(),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
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
                                child: Text(
                                  "Nama rumah sakit ini adalah Rumah Sakit Cendana Premier",
                                  style: TextStyle(),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                        text:
                                            "Visi, Misi, Falsafah dan Tujuan Rumah Sakit Cendana Premier",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
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
                                  controller.launchEmail("example@example.com");
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
                                          Text("example@example.com"),
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
                                  controller.lauchPhoneCall("+6280000000000");
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
                                          Text("+62 80000000000"),
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
                                  controller
                                      .launchWebsite(Uri.https('example.com'));
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
                                          Text("https://example.com/"),
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
