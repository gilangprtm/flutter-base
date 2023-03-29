import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_text_component.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

class DaftarRawatJalanController extends GetxController with GetTickerProviderStateMixin{
  final InputTextController searchCon = InputTextController();
  RxBool bottomNavTap = false.obs;
  late TabController tabController = TabController(length: 2, vsync: this);
  final bottomPadding = Get.bottomBarHeight;
  toDokterTab (){
    Get.toNamed(Routes.DOKTER_TAB);
  }


}
