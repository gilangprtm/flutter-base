import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_dropdown_component.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_radio_component.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_text_component.dart';
import 'package:haimed_getx/app/models/jadwal_praktek_model.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';

class DokterKonfirmasiTabController extends GetxController {
  late InputDropdownController namaPasienCon;
  late InputRadioController tipePasienCon;
  final InputTextController nrmCon =
      InputTextController(type: InputTextType.number);
  final InputTextController noHPCon =
      InputTextController(type: InputTextType.number);

  RxBool pilihPasien = false.obs;
  RxString dokterID = "".obs;
  RxString tanggal = "".obs;
  RxString sectionID = "".obs;
  RxString waktuID = "".obs;
  RxString photoUrl = "".obs;

  @override
  void onInit() {
    dokterID.value = Get.parameters['dokterID']!;
    tanggal.value = Get.parameters['tanggal']!;
    sectionID.value = Get.parameters['sectionID']!;
    waktuID.value = Get.parameters['waktuID']!;
    photoUrl.value = Get.parameters['photoUrl']!;
    namaPasienCon = InputDropdownController(
      items: [
        DropdownItem.simple("Nama Pasien 1"),
        DropdownItem.simple("Nama Pasien 2"),
      ],
    );

    tipePasienCon = InputRadioController(items: [
      RadioButtonItem(text: "Pasien Baru", value: false),
      RadioButtonItem(text: "Pasien Lama", value: true),
    ], onChanged: (item) => pilihPasien.value = item.value);
    tipePasienCon.value = pilihPasien.value;
    super.onInit();
  }

  void goToTambahPasien() {
    Get.toNamed(Routes.TAMBAH_PASIEN);
  }

  Future<JadwalpraktekModel> getDataDokter() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();

    var res = JadwalpraktekModel().obs;

    try {
      var r = await HttpApi.get(
          "https://apps.sanatasystem.net/HaimedSanataDev/api/JadwalPraktek/ByIds?tanggal=${tanggal.value}&dokterId=${dokterID.value}&sectionId=${sectionID.value}&waktuId=${waktuID.value}");
      if (r.success) {
        res.value = JadwalpraktekModel.fromJson(r.body);
        // return res;
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }
    EasyLoading.dismiss();
    return res.value;
  }
}
