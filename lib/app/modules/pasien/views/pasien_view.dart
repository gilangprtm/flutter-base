// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../../models/cuti_hamil_model.dart';
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
      body: ListView.builder(
        itemCount: 3,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 131,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(
                        Radius.circular(MahasThemes.borderRadius)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Putu Gilang Pratama"),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            child: Text("NIK"),
                          ),
                          Row(
                            children: [
                              Text(" : "),
                              Text("009891928193792379"),
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
                              Text("Selasa, 21 April 1998"),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              controller.addOnPress();
                            },
                            child: Text("Ubah Data"),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.toReservasi();
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
          );
        },
      ),
      // ListComponent(
      //   controller: controller.listCon,
      //   itemBuilder: (CutihamilModel e) {
      //     return InkWell(
      //       onTap: () => controller.itemOnTab(e.id!),
      //       child: Padding(
      //         padding:
      //             const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      //         child: Row(
      //           children: [
      //             Expanded(
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     "Anak ke- ${e.akakke}",
      //                     // style: MahasThemes.title,
      //                   ),
      //                   const SizedBox(height: 5),
      //                   Text(
      //                     e.pegawaikadiv.toString(),
      //                     // style: MahasThemes.title,
      //                   ),
      //                   e.approvekadiv.toString() == "null"
      //                       ? Row(
      //                           children: const [
      //                             Icon(
      //                               FontAwesomeIcons.clock,
      //                               size: 12,
      //                             ),
      //                             Text(" Menunggu")
      //                           ],
      //                         )
      //                       : e.approvekadiv == false
      //                           ? Row(
      //                               children: const [
      //                                 Icon(
      //                                   FontAwesomeIcons.circleXmark,
      //                                   size: 12,
      //                                   color: MahasColors.red,
      //                                 ),
      //                                 Text(
      //                                   " Ditolak",
      //                                   style:
      //                                       TextStyle(color: MahasColors.red),
      //                                 )
      //                               ],
      //                             )
      //                           : Row(
      //                               children: const [
      //                                 Icon(
      //                                   FontAwesomeIcons.check,
      //                                   size: 12,
      //                                   // color: MahasColor.colorGreen,
      //                                 ),
      //                                 Text(
      //                                   " Diterima",
      //                                   style: TextStyle(
      //                                       // color: MahasColor.colorGreen,
      //                                       ),
      //                                 )
      //                               ],
      //                             ),
      //                   const SizedBox(height: 5),
      //                   Text(
      //                     e.pegawaimanager.toString(),
      //                     // style: MahasThemes.title,
      //                   ),
      //                   e.approvemanager.toString() == "null"
      //                       ? Row(
      //                           children: [
      //                             Visibility(
      //                               visible: e.approvekadiv != false,
      //                               child: const Icon(
      //                                 FontAwesomeIcons.clock,
      //                                 size: 12,
      //                               ),
      //                             ),
      //                             Text(e.approvekadiv == false
      //                                 ? "Tidak dilanjutkan"
      //                                 : " Menunggu")
      //                           ],
      //                         )
      //                       : e.approvemanager == false
      //                           ? Row(
      //                               children: const [
      //                                 Icon(
      //                                   FontAwesomeIcons.circleXmark,
      //                                   size: 12,
      //                                   color: MahasColors.red,
      //                                 ),
      //                                 Text(
      //                                   " Ditolak",
      //                                   style: TextStyle(
      //                                     color: MahasColors.red,
      //                                   ),
      //                                 )
      //                               ],
      //                             )
      //                           : Row(
      //                               children: const [
      //                                 Icon(
      //                                   FontAwesomeIcons.check,
      //                                   size: 12,
      //                                   // color: MahasColor.colorGreen,
      //                                 ),
      //                                 Text(
      //                                   " Diterima",
      //                                   style: TextStyle(
      //                                       // color: MahasColor.colorGreen,
      //                                       ),
      //                                 )
      //                               ],
      //                             ),
      //                 ],
      //               ),
      //             ),
      //             Text(
      //               MahasFormat.displayDate(e.daritanggal),
      //               // style: MahasColor.muted,
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
