import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../mahas/models/menu_item_model.dart';
import '../../../routes/app_pages.dart';

class SupportController extends GetxController {
  final List<MenuItemModel> menus = [];

  void toFAQ() {
    Get.toNamed(Routes.SUPPORT_FAQ);
  }

  void cAbsensiDivisi() {
    print("object");
  }

  final count = 0.obs;
  @override
  void onInit() {
    menus.add(
        MenuItemModel('Pertanyaan Yang Sering Diajukan', Icons.chat, toFAQ));
    menus.add(
        MenuItemModel('Privacy Policy', FontAwesomeIcons.lock, cAbsensiDivisi));
    menus
        .add(MenuItemModel('Syarat dan Ketentuan', Icons.list, cAbsensiDivisi));
    menus.add(MenuItemModel(
        'Tentang Perusahaan', FontAwesomeIcons.info, cAbsensiDivisi));
    menus.add(MenuItemModel('Ganti Bahasa', Icons.web, cAbsensiDivisi));
    menus.add(MenuItemModel(
        'Buku Panduan Aplikasi', FontAwesomeIcons.calendar, cAbsensiDivisi));
    super.onInit();
  }
}
