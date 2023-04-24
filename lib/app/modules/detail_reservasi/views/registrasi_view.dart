// ignore_for_file: camel_case_types, dead_code
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';

class RegistrasiView extends StatelessWidget {
  final String? noreg;
  final String? nama;
  final String? statusPeriksa;
  final String? statusResep;

  const RegistrasiView({
    Key? key,
    this.noreg,
    this.nama,
    this.statusPeriksa,
    this.statusResep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var resep = true;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 85,
              child: Text(
                "No. Registrasi",
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
                  noreg ?? "",
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
                "Nama",
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
                  nama ?? "",
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
                "Status Periksa",
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
                  statusPeriksa ?? "",
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
        Visibility(
          visible: true,
          child: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: resep ? MahasColors.grey : MahasColors.green,
                borderRadius: BorderRadius.circular(10)),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  Get.dialog(
                    AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            textAlign: TextAlign.center,
                            "Status Resep",
                            style: TextStyle(
                              fontSize: 16,
                              // color: MahasColors.primary,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(statusResep ?? ""),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(3),
                  child: Text(
                    "Status\nResep",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
