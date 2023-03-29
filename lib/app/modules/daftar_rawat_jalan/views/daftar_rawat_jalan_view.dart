import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import 'package:haimed_getx/app/modules/dokter_tab/views/dokter_tab_view.dart';
import 'package:haimed_getx/app/modules/spesialisasi_tab/views/spesialisasi_tab_view.dart';

import '../controllers/daftar_rawat_jalan_controller.dart';

class DaftarRawatJalanView extends GetView<DaftarRawatJalanController> {
  const DaftarRawatJalanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('RS. Bayangkara Denpasar'),
        centerTitle: false,
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [DokterTabView(), SpesialisasiTabView()],
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bottomNavBar() {
    return SizedBox(
      height: 50,
      child: ColoredBox(
        color: MahasColors.primary,
        child: TabBar(
          isScrollable: false,
          labelColor: MahasColors.light,
          unselectedLabelColor: MahasColors.light.withOpacity(0.6),
          indicatorColor: MahasColors.red,
          controller: controller.tabController,
          tabs: [
            SizedBox(
              width: Get.size.width / 2,
              child: Tab(
                child: Center(
                    child: Text(
                  "DOKTER",
                  style: MahasThemes.h3,
                )),
              ),
            ),
            SizedBox(
              width: Get.size.width / 2,
              child: Tab(
                child: Center(
                  child: Text(
                    "SPESIALISASI",
                    style: MahasThemes.h3,
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
