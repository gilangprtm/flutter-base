import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';

import '../../../mahas/services/http_api.dart';
import '../../../models/jadwal_praktek_model.dart';
import '../../../models/lampiran_konfirmasi_model.dart';

class NotifikasiDetailController extends GetxController {
  late JadwalpraktekModel jadwalModel;
  late LampirankonfirmasikedatanganModel lampiranModel;
  String? judul;
  String? pesan;
  String? spesialisasi;
  String? dokter;
  String? kodeunik;

  @override
  void onInit() {
    kodeunik = Get.arguments['kodeunik'];
    if (Get.arguments['tipenotifikasi'] == 3 ||
        Get.arguments['tipenotifikasi'] == 4) {
      lampiranModel = Get.arguments['model'];
      spesialisasi = lampiranModel.namaspesialisasi;
    } else {
      jadwalModel = Get.arguments['model'];
      spesialisasi = jadwalModel.spesialisname;
    }
    if (Get.arguments['dibaca'] == false) {
      dibaca();
    }
    judul = Get.arguments['judul'];
    pesan = Get.arguments['pesan'];
    super.onInit();
  }

  void dibaca() async {
    final body = {};
    final url =
        '/api/Notifikasi/TerbacaByKodeUnik?userId=${MahasConfig.profile!.userIdHaimed}&kodeUnik=$kodeunik';
    await HttpApi.patch(
      url,
      body: body,
    );
  }
}
