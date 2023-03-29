// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../../models/pasien_model.dart';
import '../controllers/pasien_controller.dart';

class PasienView extends GetView<PasienController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pasien'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MahasColors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          controller.addOnPress();
        },
      ),
      body: ListComponent(
        controller: controller.listCon,
        itemBuilder: (PasienModel e) {
          return InkWell(
            onTap: () {
              controller.itemOnTab(e.pasienidhaimed!);
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 131,
                    decoration: BoxDecoration(
                      // color: Colors.grey[100],
                      borderRadius: BorderRadius.all(
                          Radius.circular(MahasThemes.borderRadius)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.nama!),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              child: Text("NIK"),
                            ),
                            Row(
                              children: [
                                Text(" : "),
                                Text(e.nik!),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              child: Text("Tgl Lahir"),
                            ),
                            Row(
                              children: [
                                Text(" : "),
                                Text(MahasFormat.displayDate(e.tanggallahir)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.toReservasi(e.pasienidhaimed!);
                              },
                              child: Text("Reservasi"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
