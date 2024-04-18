import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/mahas_colors.dart';
import '../controllers/support_controller.dart';

class SupportView extends GetView<SupportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pusat Bantuan'),
        centerTitle: true,
        backgroundColor: MahasColors.primary,
      ),
      body: ListView.separated(
        itemBuilder: (context, i) => ListTile(
          title: Text(controller.menus[i].title),
          leading: Icon(controller.menus[i].icon),
          onTap: controller.menus[i].onTab,
        ),
        itemCount: controller.menus.length,
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
          );
        },
      ),
    );
  }
}
