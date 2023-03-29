import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      body: ListComponent(
        controller: controller.listCon,
        itemBuilder: (DokterfavModel e) {
          return ListTile(
            onTap: () => controller.itemOnTab(e.dokterid!),
            leading: ClipOval(
              child: Image.asset(
                "assets/images/Doctor.png",
                // width: 60,
                height: 50,
              ),
            ),
            title: Text(
              e.namadokter!,
              style: MahasThemes.h3,
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.kategoriName!,
                  style: MahasThemes.link,
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                ),
                Text(
                  e.spesialisname!,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
