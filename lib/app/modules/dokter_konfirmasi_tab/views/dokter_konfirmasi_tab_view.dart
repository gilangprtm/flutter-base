import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_dropdown_component.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_radio_component.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_text_component.dart';
import 'package:haimed_getx/app/mahas/services/mahas_format.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../models/jadwal_praktek_model.dart';
import '../controllers/dokter_konfirmasi_tab_controller.dart';

class DokterKonfirmasiTabView extends GetView<DokterKonfirmasiTabController> {
  const DokterKonfirmasiTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi'),
        centerTitle: false,
      ),
      body: FutureBuilder<JadwalpraktekModel>(
        future: controller.getDataDokter(),
        builder: (context, snap) => snap.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(
                  color: MahasColors.primary,
                ),
              )
            : Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(
                                  MahasThemes.borderRadius),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: MahasColors.light,
                                  borderRadius: BorderRadius.circular(
                                      MahasThemes.borderRadius),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Obx(
                                        () => snap.data!.fotodokter != ""
                                            ? Image.network(
                                                snap.data!.fotodokter!,
                                                width: 60,
                                                height: 60,
                                              )
                                            : Image.asset(
                                                "assets/images/Doctor.png",
                                                width: 60,
                                                height: 60,
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snap.data!.namadokter ?? "",
                                            style: MahasThemes.h3,
                                            overflow: TextOverflow.visible,
                                            maxLines: 4,
                                          ),
                                          Divider(
                                            thickness: 1,
                                            height: 5,
                                          ),
                                          SizedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.health_and_safety,
                                                  color: MahasColors.grey,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    snap.data!.spesialisname ??
                                                        "",
                                                    style: MahasThemes.muted,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.visible,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.watch_later_outlined,
                                                color: MahasColors.grey,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${MahasFormat.displayTime(TimeOfDay.fromDateTime(snap.data!.fromjam!))} - ${MahasFormat.displayTime(TimeOfDay.fromDateTime(snap.data!.tojam!))}",
                                                  style: MahasThemes.muted,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.meeting_room,
                                                color: MahasColors.grey,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snap.data!.noruang ?? "-",
                                                  style: MahasThemes.muted,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snap.data!.jmlpasienreservasi
                                                .toString(),
                                            style: MahasThemes.h1,
                                          ),
                                          Text(
                                            "Pasien",
                                            style: MahasThemes.mutedH3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(
                                  MahasThemes.borderRadius),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: MahasColors.light,
                                  borderRadius: BorderRadius.circular(
                                      MahasThemes.borderRadius),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.25,
                                          child: Text(
                                            "Tanggal",
                                            style: MahasThemes.mutedH3,
                                          ),
                                        ),
                                        Text(
                                          ":  ",
                                          style: MahasThemes.mutedH3,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            child: Text(
                                              MahasFormat.displayDate(
                                                  snap.data!.tanggal),
                                              style: MahasThemes.mutedH3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.25,
                                          child: Text(
                                            "Status",
                                            style: MahasThemes.mutedH3,
                                          ),
                                        ),
                                        Text(
                                          ":  ",
                                          style: MahasThemes.mutedH3,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            child: Text(
                                                snap.data!.statuspraktek ?? "-",
                                                style: MahasThemes.primaryH3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.25,
                                          child: Text(
                                            "Information",
                                            style: MahasThemes.mutedH3,
                                          ),
                                        ),
                                        Text(
                                          ":  ",
                                          style: MahasThemes.mutedH3,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            child: Text(
                                              snap.data!
                                                      .keteranganstatuspraktek ??
                                                  "-",
                                              style: MahasThemes.mutedH3,
                                              overflow: TextOverflow.visible,
                                              maxLines: 3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(
                                  MahasThemes.borderRadius),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: MahasColors.light,
                                  borderRadius: BorderRadius.circular(
                                      MahasThemes.borderRadius),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            child: InputDropdownComponent(
                                              label: "Pilih Nama Pasien",
                                              controller:
                                                  controller.namaPasienCon,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              controller.goToTambahPasien(),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: MahasColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MahasThemes.borderRadius),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.add,
                                                size: 30,
                                                color: MahasColors.light,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    InputRadioComponent(
                                      controller: controller.tipePasienCon,
                                      label: "Pilih Tipe Pasien",
                                    ),
                                    Obx(
                                      () => Visibility(
                                        visible: controller.pilihPasien.value,
                                        child: InputTextComponent(
                                          placeHolder: "NRM",
                                          controller: controller.nrmCon,
                                          required:
                                              controller.pilihPasien.value ==
                                                      true
                                                  ? true
                                                  : false,
                                        ),
                                      ),
                                    ),
                                    InputTextComponent(
                                      placeHolder: "Telepon",
                                      controller: controller.noHPCon,
                                      required: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: MahasColors.darkwhite,
                        width: Get.width,
                        child: ElevatedButton(
                            onPressed: () {
                              print("works!");
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MahasColors.primary),
                            child: Text(
                              "RESERVASI",
                              style: MahasThemes.h3White,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
