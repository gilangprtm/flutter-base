// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/services/mahas_format.dart';

class ReservasiView extends StatelessWidget {
  final String noReservasi;
  final String? nrm;
  final String? sectionName;
  final String? statusReservasi;
  final String? keterangan;
  final String? memo;
  final DateTime? tanggal;
  final int? noUrut;
  final int? noAntrian;

  const ReservasiView({
    Key? key,
    required this.noReservasi,
    this.tanggal,
    this.noUrut,
    this.noAntrian,
    this.nrm,
    this.sectionName,
    this.keterangan,
    this.statusReservasi,
    this.memo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
              ),
              child: QrImage(
                data: noReservasi,
                version: QrVersions.auto,
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No Reservasi",
                      style: MahasThemes.h3,
                    ),
                    Text(
                      noReservasi,
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
                          MahasFormat.displayDate(tanggal),
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
            "RS Cendana Premier",
            style: MahasThemes.h2,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: Get.width,
          child: Text(
            "$noUrut",
            style: MahasThemes.muted
                .copyWith(fontSize: 45, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: Get.width,
          child: Text(
            "Sisa Antrian : ${noUrut ?? 0 - noAntrian!}",
            style: MahasThemes.h1.copyWith(color: MahasColors.green),
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
                  nrm ?? "-",
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
                  sectionName ?? "-",
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
                  statusReservasi ?? "-",
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
                  keterangan ?? "-",
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
                  memo ?? "-",
                  style: MahasThemes.normal,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.visible,
                  maxLines: 3,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
