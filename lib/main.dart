import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/mahas_service.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await MahasService.init();
  runApp(
    GetMaterialApp(
      theme: MahasThemes.light,
      title: "Application",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    ),
  );
}
