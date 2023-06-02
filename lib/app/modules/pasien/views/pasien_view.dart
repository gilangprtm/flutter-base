// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../../mahas_complement/coachmaker/coachmaker.dart';
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
      floatingActionButton: CoachPoint(
        initial: '1',
        child: FloatingActionButton(
          backgroundColor: MahasColors.primary,
          child: const Icon(Icons.add),
          onPressed: () {
            controller.addOnPress();
          },
        ),
      ),
      body: ListComponent(
        controller: controller.listCon,
        separatorBuilder: (context, index, length) => Divider(
          height: 0,
          thickness: 0,
        ),
        itemBuilder: (PasienModel e) {
          return InkWell(
            onTap: () {
              controller.itemOnTab(e.pasienidhaimed!);
            },
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.nama!,
                                    style: MahasThemes.h2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              controller.toPasienSetup(e.pasienidhaimed!);
                            },
                            icon: Icon(
                              Icons.person,
                            ),
                            label: Text(
                              "Ubah Data",
                              style: MahasThemes.link,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      height: 0,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                          Text(MahasFormat.displayDate(
                                              e.tanggallahir)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.toReservasi(e.pasienidhaimed!);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Riwayat\nReservasi",
                                  style: MahasThemes.normalWhite
                                      .copyWith(height: 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
