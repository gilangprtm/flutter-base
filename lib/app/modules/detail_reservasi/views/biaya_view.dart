// ignore_for_file: camel_case_types, dead_code
import 'package:flutter/material.dart';
import 'package:haimed_getx/app/mahas/services/mahas_format.dart';

import '../../../mahas/components/mahas_themes.dart';

class BiayaView extends StatelessWidget {
  final double? deposit;
  final double? biayaSementara;

  const BiayaView({
    Key? key,
    this.deposit,
    this.biayaSementara,
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
                "Deposit Pembayaran",
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
                  "Rp. ${MahasFormat.toCurrency(deposit)}",
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
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 85,
              child: Text(
                "Biaya Sementara",
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
                  "Rp. ${MahasFormat.toCurrency(biayaSementara)}",
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
