// ignore_for_file: camel_case_types, dead_code
import 'package:flutter/material.dart';
import 'package:haimed_getx/app/mahas/services/mahas_format.dart';

import '../../../mahas/components/mahas_themes.dart';

class PembayaranView extends StatelessWidget {
  final String? noReservasi;
  final String? noPembayaran;
  final double? jumlahBayar;

  const PembayaranView({
    Key? key,
    this.noReservasi,
    this.noPembayaran,
    this.jumlahBayar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 85,
              child: Text(
                "No. Reservasi",
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
                  noReservasi ?? "",
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
                "No. Pembayaran",
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
                  noPembayaran ?? "",
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
                "Jumlah Bayar",
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
                  "Rp. ${MahasFormat.toCurrency(jumlahBayar)}",
                  style:
                      MahasThemes.normal.copyWith(fontWeight: FontWeight.bold),
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
