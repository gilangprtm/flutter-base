import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haimed_getx/app/mahas/services/mahas_format.dart';

import '../../../mahas/mahas_service.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/biaya_sementara_model.dart';
import '../../../models/reservasi_model.dart';
import '../../../routes/app_pages.dart';
import '../../ulasan/ulasan/controllers/ulasan_ulasan_controller.dart';

class DetailReservasiController extends GetxController {
  late String? reservasi;
  late String? reservasiList;
  late ReservasiModel reservasiModel;
  late BiayasementaraModel biayaSementara;
  late double biayasementara;
  late double deposit;
  RxBool isLoad = false.obs;
  late UlasanUlasanController ulasan;
  final box = GetStorage();
  RxString dateStorage = ''.obs;
  RxBool sudahUlas = false.obs;

  @override
  void onInit() async {
    reservasi = Get.parameters['reservasi'];
    dateStorage.value = box.read("endDate") ?? '';
    ulasan = Get.isRegistered<UlasanUlasanController>()
        ? Get.find<UlasanUlasanController>()
        : Get.put(UlasanUlasanController());
    if (reservasi != null) {
      reservasiModel = ReservasiModel.fromJson(reservasi!);
      biayasementara = 0;
      deposit = 0;
      isLoad.value = true;
    } else {
      reservasiList = Get.parameters['reservasiList']!;
      await getDataReservasi();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    for (var e in ulasan.models) {
      if (e.useridhaimed == auth.currentUser!.uid) {
        sudahUlas.value = true;
      } else {
        sudahUlas.value = false;
      }
    }
    DateTime? date = MahasFormat.stringToDateTime(dateStorage.value);
    if (sudahUlas.isFalse) {
      if (date != null && DateTime.now().isAfter(date)) {
        await ulasan.dialogRating(
          controller: ulasan.ratingCon,
          backOnPressed: () async {
            if (dateStorage.value != '') {
              box.remove("endDate");
            }
            await box.write("endDate",
                DateTime.now().add(const Duration(days: 6)).toString());
            Get.back(result: false);
          },
        );
      } else if (date == null) {
        await ulasan.dialogRating(
          controller: ulasan.ratingCon,
          backOnPressed: () async {
            if (dateStorage.value != '') {
              box.remove("endDate");
            }
            await box.write("endDate",
                DateTime.now().add(const Duration(days: 6)).toString());
            Get.back(result: false);
          },
        );
      }
    }
    super.onReady();
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
        if (reservasiModel.noreg != null) {
          await getBiayaSementara(reservasiModel.noreg!);
          deposit = biayaSementara.deposit!;
          biayasementara = biayaSementara.biayasementara!;
        } else {
          deposit = 0;
          biayasementara = 0;
        }
        isLoad.value = true;
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }
    EasyLoading.dismiss();
  }

  Future getBiayaSementara(String noreg) async {
    try {
      var r = await HttpApi.get("/api/BiayaPasien/RekapSementara/$noreg");

      if (r.success) {
        biayaSementara = BiayasementaraModel.fromJson(r.body);
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }
  }

  Future<bool> backOnPressed() async {
    if (reservasi != null) {
      Get.offAllNamed(Routes.home);
    } else if (reservasiList != null) {
      Get.back();
    }
    return true;
  }
}
