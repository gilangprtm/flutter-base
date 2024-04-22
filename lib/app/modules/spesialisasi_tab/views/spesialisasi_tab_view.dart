import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/components/others/list_component.dart';

import '../../../mahas/mahas_colors.dart';
import '../../../mahas/services/helper.dart';
import '../../../models/spesialisasi_model.dart';
import '../controllers/spesialisasi_tab_controller.dart';

class SpesialisasiTabView extends GetView<SpesialisasiTabController> {
  const SpesialisasiTabView({super.key});
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
            leading: InkWell(
              onTap: () async => await Helper.dialogFoto(e.spesialisasiURL,
                  "assets/images/Doctor.png", e.namaspesialisasi),
              child: ClipOval(
                child: e.spesialisasiURL != null
                    ? Image.network(
                        e.spesialisasiURL!,
                        width: 50,
                        height: 50,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 60,
                            width: 60,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: MahasColors.primary,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        "assets/images/ic_poli_default.PNG",
                        width: 50,
                        height: 50,
                      ),
              ),
            ),
            horizontalTitleGap: 15,
            title: Text(
              e.namaspesialisasi ?? "",
              style: MahasThemes.h3,
            ),
          );
        },
      ),
    );
  }
}
