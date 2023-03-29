import 'package:get/get.dart';

class MenuItemModel {
  final String title;
  final String answer;
  bool tap;

  MenuItemModel(this.title, this.answer, this.tap);
}

class SupportFaqController extends GetxController {
  final List<MenuItemModel> menus = [];
  RxBool isLoad = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    tapRefresh();
    menus.add(MenuItemModel(
        'Apa itu HaiMed?',
        'HaiMed adalah sebuah aplikasi kesehatan yang bisa melakukan proses reservasi disetiap rumah sakit.',
        false));
    menus.add(MenuItemModel(
        'Dimana alama kantor HaiMed?',
        'HaiMed merupakan product yang dimiliki oleh salah satu perusahaan IT terbesar di Bali, yaitu Sanata System.',
        false));
    menus.add(MenuItemModel('Kontak person HaiMed',
        'Nomor telepon yang bisa dihubungi (0361) 054399', false));
    super.onInit();
  }

  void tapRefresh() {
    isLoad.value = false;
    isLoad.value = true;
  }
}
