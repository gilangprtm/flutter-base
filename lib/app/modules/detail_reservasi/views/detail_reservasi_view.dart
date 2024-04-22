import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import 'package:haimed_getx/app/modules/detail_reservasi/views/biaya_view.dart';
import 'package:haimed_getx/app/modules/detail_reservasi/views/pembayaran_view.dart';
import 'package:haimed_getx/app/modules/detail_reservasi/views/registrasi_view.dart';
import 'package:haimed_getx/app/modules/detail_reservasi/views/reservasi_view.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../controllers/detail_reservasi_controller.dart';

class DetailReservasiView extends GetView<DetailReservasiController> {
  const DetailReservasiView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        controller.backOnPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Reservasi'),
          centerTitle: true,
          backgroundColor: MahasColors.primary,
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
                                ReservasiView(
                                  noReservasi:
                                      controller.reservasiModel.noreservasi!,
                                  nrm: controller.reservasiModel.nrm,
                                  tanggal:
                                      controller.reservasiModel.untuktanggal,
                                  memo: controller.reservasiModel.memo,
                                  statusReservasi:
                                      controller.reservasiModel.statusreservasi,
                                  sectionName:
                                      controller.reservasiModel.sectionname,
                                  noAntrian: controller
                                      .reservasiModel.noantriansaatini,
                                  noUrut: controller.reservasiModel.nourut,
                                  keterangan:
                                      controller.reservasiModel.keterangan,
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
                                  height: 20,
                                ),
                                Visibility(
                                  visible:
                                      controller.reservasiModel.noreg != null,
                                  child: Column(
                                    children: [
                                      RegistrasiView(
                                        nama: controller.reservasiModel.nama,
                                        noreg: controller.reservasiModel.noreg,
                                        statusPeriksa: controller
                                            .reservasiModel.statusperiksa,
                                        statusResep: controller
                                            .reservasiModel.statusresep,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ),
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
                                  height: 20,
                                ),
                                Visibility(
                                  visible:
                                      controller.reservasiModel.noreg != null,
                                  child: Column(
                                    children: [
                                      BiayaView(
                                        deposit: controller.deposit,
                                        biayaSementara:
                                            controller.biayasementara,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ),
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
                                  height: 20,
                                ),
                                Visibility(
                                  visible: controller
                                          .reservasiModel.nobuktipembayaran !=
                                      "-",
                                  child: Column(
                                    children: [
                                      PembayaranView(
                                        noReservasi: controller
                                            .reservasiModel.noreservasi,
                                        noPembayaran: controller
                                            .reservasiModel.nobuktipembayaran,
                                        jumlahBayar: controller
                                            .reservasiModel.nilaibayar,
                                      ),
                                      SizedBox(
                                        height: 40,
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
          ),
        ),
      ),
    );
  }
}
