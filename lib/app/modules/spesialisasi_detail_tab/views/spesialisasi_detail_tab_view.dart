import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/services/mahas_format.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../models/jadwal_praktek_model.dart';
import '../controllers/spesialisasi_detail_tab_controller.dart';

class SpesialisasiDetailTabView
    extends GetView<SpesialisasiDetailTabController> {
  const SpesialisasiDetailTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: false,
        actions: [
          Obx(
            () => Container(
              margin: EdgeInsets.only(right: 10),
              width: 120,
              child: TextButton.icon(
                onPressed: () => controller.datePicker(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: MahasColors.light,
                ),
                label: Text(
                  MahasFormat.displayDate(controller.dateButton.value),
                  style: MahasThemes.normalWhite,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<SpesialisasiDetailTabController>(
        builder: (c) => ListComponent(
          controller: c.getJadwal(),
          itemBuilder: (JadwalpraktekModel e) {
            return ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                InkWell(
                  onTap: () => controller.itemOnTab(),
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
                            ClipOval(
                              child: e.fotodokter != null
                                  ? Image.network(
                                      e.fotodokter!,
                                      width: 60,
                                      height: 60,
                                    )
                                  : Image.asset(
                                      "assets/images/Doctor.png",
                                      width: 60,
                                      height: 60,
                                    ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.namadokter ?? "",
                                    style: MahasThemes.h3,
                                    overflow: TextOverflow.visible,
                                    maxLines: 4,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    height: 5,
                                  ),
                                  SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.health_and_safety,
                                          color: MahasColors.red,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            e.spesialisname ?? "",
                                            style: MahasThemes.muted,
                                            maxLines: 3,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: MahasColors.green,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${MahasFormat.displayTime(TimeOfDay.fromDateTime(e.fromjam!))} - ${MahasFormat.displayTime(TimeOfDay.fromDateTime(e.tojam!))}",
                                          style: MahasThemes.muted,
                                          maxLines: 3,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.meeting_room,
                                        color: MahasColors.primary,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          e.noruang ?? "-",
                                          style: MahasThemes.muted,
                                          maxLines: 3,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
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
                                    e.jmlpasienreservasi.toString(),
                                    style: MahasThemes.h1,
                                  ),
                                  Text(
                                    "Pasien",
                                    style: MahasThemes.mutedH3,
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
