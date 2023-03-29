import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/components/others/list_component.dart';

import '../../../models/spesialisasi_model.dart';
import '../controllers/spesialisasi_tab_controller.dart';

class SpesialisasiTabView extends GetView<SpesialisasiTabController> {
  const SpesialisasiTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListComponent(
        controller: controller.listCon,
        itemBuilder: (GetSpesialisasiModel e) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            onTap: () =>
                controller.goToDetailPage(e.spesialisid!, e.namaspesialisasi!),
            title: Text(
              e.namaspesialisasi ?? "",
              style: MahasThemes.h3,
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HaiMed : ",
                  style: MahasThemes.muted,
                ),
                Text(
                  e.spesialisasiidhaimed ?? "",
                  style: MahasThemes.muted,
                ),
                Text(
                  "Spesialis : ",
                  style: MahasThemes.muted,
                ),
                Text(
                  e.spesialisid ?? "",
                  style: MahasThemes.muted,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
