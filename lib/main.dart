import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/constant/environment_constant.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/mahas/mahas_service.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Environment
  MahasConfig.currentEnv = await EnvironmentConstant.currentEnv();
  EnvironmentConstant.environment();
  MahasService.init();
  runApp(
    GetMaterialApp(
      theme: MahasThemes.light,
      title: "Haimed",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    ),
  );
}
