import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import 'package:haimed_getx/app/mahas/services/mahas_format.dart';

import '../controllers/artikel_detail_controller.dart';

class ArtikelDetailView extends GetView<ArtikelDetailController> {
  const ArtikelDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.artikel.title ?? ""),
        centerTitle: false,
        backgroundColor: MahasColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              controller.artikel.image ?? "",
              fit: BoxFit.fitWidth,
              width: Get.width,
              height: Get.height * 0.3,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress != null
                      ? Center(
                          child: Image.asset(
                            "assets/images/iosloading.gif",
                            height: 30,
                            width: 30,
                          ),
                        )
                      : child,
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: MahasColors.darkwhite,
              width: Get.width,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Admin",
                        style: MahasThemes.mutedH3,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        MahasFormat.displayDate(
                            controller.artikel.tanggal?.toDate()),
                        style: MahasThemes.mutedH3,
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  InkWell(
                    onTap: (() => controller.onTap()),
                    child: Icon(
                      Icons.share,
                      color: MahasColors.link,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: MahasColors.light,
              child: HtmlWidget(controller.artikel.deskripsi ?? ""),
            ),
          ],
        ),
      ),
    );
  }
}
