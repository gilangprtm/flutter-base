import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/components/others/list_component.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import 'package:haimed_getx/app/models/dokter_fav_model.dart';

import '../../../mahas/services/helper.dart';
import '../controllers/dokter_tab_controller.dart';

class DokterTabView extends GetView<DokterTabController> {
  const DokterTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListComponent(
        controller: controller.listCon,
        itemBuilder: (DokterfavModel e) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            onTap: () => controller.goToDokterDetail(e.dokterid!),
            leading: InkWell(
              onTap: () async => await Helper.dialogFoto(
                  e.photourl, "assets/images/Doctor.png", e.namadokter),
              child: ClipOval(
                child: e.photourl != null
                    ? Image.network(
                        e.photourl!,
                        width: 60,
                        height: 60,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 60,
                            width: 60,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: MahasColors.primary,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        "assets/images/Doctor.png",
                        width: 60,
                        height: 60,
                      ),
              ),
            ),
            title: Text(
              e.namadokter ?? "",
              style: MahasThemes.h3,
            ),
            subtitle: Row(
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
                    width: Get.width * 0.52,
                    child: Text(
                      e.spesialisname ?? "",
                      style: MahasThemes.link,
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                    )),
              ],
            ),
            trailing: InkWell(
              onTap: () {
                controller.onSelected(e.dokterid!, e.favorit!);
              },
              child: Container(
                width: 40,
                height: Get.height,
                child: e.favorit == true
                    ? Icon(
                        Icons.favorite,
                        color: MahasColors.red,
                      )
                    : Icon(
                        Icons.favorite_border_rounded,
                        color: MahasColors.red,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
