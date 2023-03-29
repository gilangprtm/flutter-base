import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import 'package:haimed_getx/app/mahas/services/mahas_format.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../controllers/detail_reservasi_controller.dart';

class DetailReservasiView extends GetView<DetailReservasiController> {
  const DetailReservasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.backOnPressed(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Reservasi'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Obx(
              () => controller.isLoad.value == false
                  ? const SizedBox()
                  : Column(
                      children: [
                        TimelineTile(
                          alignment: TimelineAlign.start,
                          isFirst: true,
                          afterLineStyle: LineStyle(thickness: 1.5),
                          indicatorStyle: IndicatorStyle(
                            indicatorXY: 0,
                            height: 25,
                            width: 25,
                            indicator: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MahasColors.primary,
                              ),
                              child: Center(
                                child: Text(
                                  "1",
                                  style: MahasThemes.h3White,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          endChild: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Langkah 1: Reservasi",
                                  style: MahasThemes.h2,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MahasThemes.borderRadius),
                                      ),
                                      child: QrImage(
                                        data: controller
                                                .reservasiModel.noreservasi ??
                                            "-",
                                        version: QrVersions.auto,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "No Reservasi",
                                              style: MahasThemes.h3,
                                            ),
                                            Text(
                                              controller.reservasiModel
                                                      .noreservasi ??
                                                  "-",
                                              style: MahasThemes.h3,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.date_range_outlined,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  MahasFormat.displayDate(
                                                      controller.reservasiModel
                                                          .tanggal),
                                                  style: MahasThemes.normal,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Silahkan registrasi menuju petugas registrasi untuk melakukan pendaftaran pasien baru / sinkronisasi pasien lama",
                                              style: MahasThemes.normal,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "RS Cendana Premiere",
                                    style: MahasThemes.h2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    controller.reservasiModel.nourut.toString(),
                                    style: MahasThemes.muted.copyWith(
                                        fontSize: 45,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width,
                                  child: Text(
                                    "Sisa Antrian : ${controller.reservasiModel.nourut ?? 0 - controller.reservasiModel.noantriansaatini!}",
                                    style: MahasThemes.h1
                                        .copyWith(color: MahasColors.green),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 85,
                                      child: Text(
                                        "No.RM",
                                        style: MahasThemes.normal,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                      child: Text(
                                        ":",
                                        style: MahasThemes.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 10,
                                        child: Text(
                                          controller.reservasiModel.nrm ?? "-",
                                          style: MahasThemes.normal,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          maxLines: 3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 85,
                                      child: Text(
                                        "Section",
                                        style: MahasThemes.normal,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                      child: Text(
                                        ":",
                                        style: MahasThemes.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 10,
                                        child: Text(
                                          controller
                                                  .reservasiModel.sectionname ??
                                              "-",
                                          style: MahasThemes.normal,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          maxLines: 3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 85,
                                      child: Text(
                                        "Status",
                                        style: MahasThemes.normal,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                      child: Text(
                                        ":",
                                        style: MahasThemes.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 10,
                                        child: Text(
                                          controller.reservasiModel
                                                  .statusreservasi ??
                                              "-",
                                          style: MahasThemes.normal,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          maxLines: 3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 85,
                                      child: Text(
                                        "Keterangan",
                                        style: MahasThemes.normal,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                      child: Text(
                                        ":",
                                        style: MahasThemes.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 10,
                                        child: Text(
                                          controller
                                                  .reservasiModel.keterangan ??
                                              "-",
                                          style: MahasThemes.normal,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          maxLines: 3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 85,
                                      child: Text(
                                        "Pemeriksaan",
                                        style: MahasThemes.normal,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                      child: Text(
                                        ":",
                                        style: MahasThemes.normal,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 10,
                                        child: Text(
                                          controller.reservasiModel.memo ?? "-",
                                          style: MahasThemes.normal,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          maxLines: 3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.start,
                          afterLineStyle: LineStyle(thickness: 1.5),
                          indicatorStyle: IndicatorStyle(
                            indicatorXY: 0,
                            height: 25,
                            width: 25,
                            indicator: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MahasColors.primary,
                              ),
                              child: Center(
                                child: Text(
                                  "2",
                                  style: MahasThemes.h3White,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          endChild: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Langkah 2: Registrasi",
                                  style: MahasThemes.h2,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.start,
                          afterLineStyle: LineStyle(thickness: 1.5),
                          indicatorStyle: IndicatorStyle(
                            indicatorXY: 0,
                            height: 25,
                            width: 25,
                            indicator: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MahasColors.primary,
                              ),
                              child: Center(
                                child: Text(
                                  "3",
                                  style: MahasThemes.h3White,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          endChild: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Langkah 3: Biaya Sementara",
                                  style: MahasThemes.h2,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.start,
                          isLast: true,
                          afterLineStyle: LineStyle(thickness: 1.5),
                          indicatorStyle: IndicatorStyle(
                            indicatorXY: 0,
                            height: 25,
                            width: 25,
                            indicator: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MahasColors.primary,
                              ),
                              child: Center(
                                child: Text(
                                  "4",
                                  style: MahasThemes.h3White,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          endChild: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Langkah 4: Pembayaran",
                                  style: MahasThemes.h2,
                                ),
                                SizedBox(
                                  height: 40,
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
      ),
    );
  }
}
