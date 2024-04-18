import 'package:get/get.dart';
import 'package:haimed_getx/app/models/artikel_firebase_model.dart';

class ArtikelDetailController extends GetxController {
  final ArtikelFirestoreModel artikel = Get.arguments["model"];
  void onTap() {
    print("Works!");
  }
}
