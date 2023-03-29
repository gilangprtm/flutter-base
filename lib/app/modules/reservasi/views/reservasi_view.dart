import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/services/mahas_format.dart';
import 'package:haimed_getx/app/models/reservasi_model.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_colors.dart';
import '../controllers/reservasi_controller.dart';

class ReservasiView extends GetView<ReservasiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Reservasi"),
        centerTitle: false,
      ),
      body: GetBuilder<ReservasiController>(
        builder: (c) => ListComponent(
          controller: c.getReservasi(),
          itemBuilder: (ReservasiModel e) {
            return ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                InkWell(
                  onTap: () => controller.toDetail(e.noreservasi!),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Material(
                      elevation: 3,
                      borderRadius:
                          BorderRadius.circular(MahasThemes.borderRadius),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: MahasColors.light,
                          borderRadius:
                              BorderRadius.circular(MahasThemes.borderRadius),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "RS. Cendana Premiere",
                                    style: MahasThemes.h2,
                                    overflow: TextOverflow.visible,
                                    maxLines: 4,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 85,
                                        child: Text(
                                          "No. RM",
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
                                            e.nrm ?? "",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            e.sectionname ?? "",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 85,
                                        child: Text(
                                          "Dokter",
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
                                            e.namadokter ?? "",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 85,
                                        child: Text(
                                          "Tanggal",
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
                                            MahasFormat.displayDate(e.tanggal),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 85,
                                        child: Text(
                                          "Untuk Tanggal",
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
                                            MahasFormat.displayDate(
                                                e.untuktanggal),
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
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No. Antrian",
                                    style: MahasThemes.mutedH3,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    e.nourut.toString(),
                                    style: MahasThemes.h1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
