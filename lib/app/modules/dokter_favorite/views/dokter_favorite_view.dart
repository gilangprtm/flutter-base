import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/components/others/list_component.dart';
import '../../../models/dokter_fav_model.dart';
import '../controllers/dokter_favorite_controller.dart';

class DokterFavoriteView extends GetView<DokterFavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dokter Favorite'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListComponent(
          controller: controller.listCon,
          separatorBuilder: (context, index, length) => SizedBox(),
          itemBuilder: (DokterfavModel e) {
            return InkWell(
              onTap: () => controller.itemOnTab(e.dokterid!),
              child: Container(
                padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
                  child: Container(
                    width: Get.width,
                    height: 100,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: e.photourl != null
                              ? Image.network(
                                  e.photourl ?? "assets/images/Doctor.png",
                                  width: 50,
                                  height: 50,
                                )
                              : Image.asset(
                                  "assets/images/Doctor.png",
                                  width: 50,
                                  height: 50,
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
                                width: Get.width - 145,
                                child: Text(
                                  e.namadokter ?? "-",
                                  style: MahasThemes.h3,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                )),
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
                                  width: Get.width - 165,
                                  child: Text(
                                    e.spesialisname ?? "-",
                                    style: MahasThemes.muted,
                                    overflow: TextOverflow.visible,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () => controller.deleteOnTap(e.dokterid!),
                          child: SizedBox(
                            height: Get.height,
                            width: 40,
                            child: Icon(
                              FontAwesomeIcons.trash,
                              color: MahasColors.danger,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
