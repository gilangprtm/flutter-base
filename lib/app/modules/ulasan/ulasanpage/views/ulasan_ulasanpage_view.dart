import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/modules/ulasan/informasi/views/ulasan_informasi_view.dart';
import 'package:haimed_getx/app/modules/ulasan/ulasan/views/ulasan_ulasan_view.dart';

import '../controllers/ulasan_ulasanpage_controller.dart';

class UlasanUlasanpageView extends GetView<UlasanUlasanpageController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(MahasConfig.informasiUmum.namars ?? ""),
          centerTitle: true,
          backgroundColor: MahasColors.primary,
        ),
        bottomNavigationBar: Material(
          color: MahasColors.primary,
          child: TabBar(
            labelColor: MahasColors.light,
            unselectedLabelColor: MahasColors.light.withOpacity(0.6),
            indicatorColor: MahasColors.primary.withRed(20),
            tabs: [
              Tab(
                text: "Informasi",
              ),
              Tab(
                text: "Ulasan",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UlasanInformasiView(),
            UlasanUlasanView(),
          ],
        ),
      ),
    );
  }
}
