import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/reservasi_model.dart';
import '../../../routes/app_pages.dart';

class DetailReservasiController extends GetxController {
  late String? reservasi;
  late String? reservasiList;
  late ReservasiModel reservasiModel;
  RxBool isLoad = false.obs;

  @override
  void onInit() async {
    reservasi = Get.parameters['reservasi'];
    if (reservasi != null) {
      reservasiModel = ReservasiModel.fromJson(reservasi!);
      isLoad.value = true;
    } else {
      reservasiList = Get.parameters['reservasiList']!;
      print(reservasiList);
      await getDataReservasi();
    }

    print(reservasi);
    super.onInit();
  }

  Future getDataReservasi() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();
    try {
      var r = await HttpApi.get("/api/Reservasi/$reservasiList");

      if (r.success) {
        reservasiModel = ReservasiModel.fromJson(r.body);
        isLoad.value = true;
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }
    EasyLoading.dismiss();
  }

  Future<bool> backOnPressed() async {
    Get.offAllNamed(Routes.home);
    return true;
  }
}
