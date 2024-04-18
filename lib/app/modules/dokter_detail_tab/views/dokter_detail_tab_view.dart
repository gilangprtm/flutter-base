import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import '../../../mahas/components/others/shimmer_component.dart';
import '../controllers/dokter_detail_tab_controller.dart';

class DokterDetailTabView extends GetView<DokterDetailTabController> {
  const DokterDetailTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalender Praktek'),
        centerTitle: false,
        backgroundColor: MahasColors.primary,
      ),
      body: Container(
        color: MahasColors.light,
        child: Column(
          children: [
            Container(
              width: Get.width,
              color: MahasColors.light,
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Obx(
                      () => controller.dokterCon.value.photourl != null
                          ? Image.network(
                              controller.dokterCon.value.photourl ??
                                  "assets/images/Doctor.png",
                              width: 100,
                              height: 100,
                            )
                          : Image.asset(
                              "assets/images/Doctor.png",
                              width: 100,
                              height: 100,
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width - 140,
                        child: Obx(
                          () => controller.dokterCon.value.spesialisname != null
                              ? Text(
                                  controller.dokterCon.value.namadokter!,
                                  style: MahasThemes.h2,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                )
                              : const ShimmerComponent(
                                  count: 1,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/Doctor.png",
                            width: 15,
                            height: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: Get.width - 160,
                            child: Obx(
                              () => controller.dokterCon.value.spesialisname !=
                                      null
                                  ? Text(
                                      controller.dokterCon.value.spesialisname!,
                                      style: MahasThemes.muted,
                                      overflow: TextOverflow.visible,
                                      maxLines: 2,
                                    )
                                  : const ShimmerComponent(
                                      count: 1,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => ExpansionPanelList(
                    expansionCallback: (panelIndex, isExpanded) {
                      controller.praktekExpand[panelIndex].isExpanded!.value =
                          !isExpanded;
                    },
                    expandedHeaderPadding: EdgeInsets.all(0),
                    elevation: 0,
                    children: controller.praktekExpand.map<ExpansionPanel>(
                      (PraktekExpand item) {
                        return ExpansionPanel(
                          canTapOnHeader: true,
                          headerBuilder: ((context, isExpanded) {
                            return ListTile(
                              title: Text(
                                item.header!,
                                style: MahasThemes.h2,
                              ),
                            );
                          }),
                          isExpanded: item.isExpanded!.value,
                          body: item.body!,
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
