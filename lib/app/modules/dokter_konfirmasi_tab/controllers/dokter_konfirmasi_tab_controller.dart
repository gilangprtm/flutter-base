import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_dropdown_component.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_radio_component.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_text_component.dart';
import 'package:haimed_getx/app/models/jadwal_praktek_model.dart';
import 'package:haimed_getx/app/models/pasien_model.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

import '../../../mahas/mahas_service.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';

class DokterKonfirmasiTabController extends GetxController {
  final namaPasienCon = InputDropdownController();
  late InputRadioController tipePasienCon;
  final InputTextController nrmCon = InputTextController();
  final InputTextController noHPCon =
      InputTextController(type: InputTextType.number);

  RxBool pilihPasien = false.obs;
  RxString dokterID = "".obs;
  RxString tanggal = "".obs;
  RxString sectionID = "".obs;
  RxString waktuID = "".obs;
  RxString namaSection = "".obs;
  var pasienList = RxList<PasienModel>();
  var jadwalPraktekModel = JadwalpraktekModel().obs;
  late Rx<PasienModel?> selectedPasien;

  @override
  void onInit() async {
    dokterID.value = Get.parameters['dokterID']!;
    tanggal.value = Get.parameters['tanggal']!;
    sectionID.value = Get.parameters['sectionID']!;
    waktuID.value = Get.parameters['waktuID']!;
    namaSection.value = Get.parameters['namaSection']!;
    tipePasienCon = InputRadioController(
        items: [
          RadioButtonItem(text: "Pasien Baru", value: false),
          RadioButtonItem(text: "Pasien Lama", value: true),
        ],
        onChanged: (item) {
          pilihPasien.value = item.value;
        });
    tipePasienCon.value = pilihPasien.value;
    if (auth.currentUser!.phoneNumber != null) {
      noHPCon.value = auth.currentUser!.phoneNumber;
      noHPCon.onChanged = (value) => telpOnTap();
    } else {
      noHPCon.onTap = () => telpOnTap();
    }
    super.onInit();
  }

  void pasienonChanged(PasienModel? val) {
    selectedPasien.value = val!;
  }

  void telpOnTap() {
    Get.toNamed(Routes.PHONE_LOGIN);
  }

  void goToTambahPasien() {
    Get.toNamed(Routes.PASIEN_SETUP, parameters: {"getData": true.toString()})!
        .then((value) => {
              getDataPasien(),
            });
  }

  Future<JadwalpraktekModel> getDataDokter() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();

    try {
      var r = await HttpApi.get(
          "/api/JadwalPraktek/ByIds?tanggal=${tanggal.value}&dokterId=${dokterID.value}&sectionId=${sectionID.value}&waktuId=${waktuID.value}");
      if (r.success) {
        jadwalPraktekModel.value = JadwalpraktekModel.fromJson(r.body);
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }
    await getDataPasien();
    EasyLoading.dismiss();
    return jadwalPraktekModel.value;
  }

  Future getDataPasien() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();
    try {
      var r = await HttpApi.get(
          "/api/PasienHaiMed?userId=${auth.currentUser!.uid}");
      if (r.success) {
        final datas = json.decode(r.body);
        final data = datas['Data'];
        pasienList.clear();
        for (var e in data) {
          pasienList.add(PasienModel.fromDynamic(e));
        }
        namaPasienCon.items = pasienList
            .map<DropdownItem>((e) => DropdownItem.init(e.nama, e.useridhaimed))
            .toList();
        selectedPasien = pasienList.firstWhereOrNull((e) => e.nama != null).obs;
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }
    EasyLoading.dismiss();
  }

  Future postReservasi() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();

    if (noHPCon.value != null) {
      try {
        var res = await HttpApi.post('/api/Reservasi', body: {
          "Alamat": selectedPasien.value!.alamat ?? "",
          "Batal": false,
          "NilaiBayar": 0.0,
          "Nama": selectedPasien.value!.nama ?? "",
          "UntukTanggal": jadwalPraktekModel.value.tanggal!.toString(),
          "MobileKeteranganPasienBaru": tipePasienCon.value,
          "NRM": nrmCon.value ?? "",
          "UntukDokterID": dokterID.value,
          "UntukSectionID": sectionID.value,
          "NamaSection": namaSection.value,
          "WaktuID": waktuID.value,
          "MobileKeteranganNRM": nrmCon.value ?? "",
          "NIK": selectedPasien.value!.nik ?? "",
          "MobileNotifikasiAktif": false,
          "MobileTglLahirPasien": selectedPasien.value!.tanggallahir.toString(),
          "TanggalLahir": selectedPasien.value!.tanggallahir.toString(),
          "NoUrut": 0,
          "Tanggal": DateTime.now().toString(),
          "HaiMedUserId": auth.currentUser!.uid,
          "HaiMedRelasiId": selectedPasien.value!.pasienidhaimed ?? "",
          "Phone": auth.currentUser!.phoneNumber!,
          "Memo": ""
        });

        if (res.success) {
          Get.toNamed(Routes.DETAIL_RESERVASI,
              parameters: {"reservasi": res.body.toString()});
        } else {
          if (res.message == "") {
            Helper.dialogWarning(
                "Tidak dapat melakukan reservasi lebih dari sekali");
          } else {
            Helper.dialogWarning(res.message);
          }
        }
      } catch (e) {
        Helper.dialogWarning(e.toString());
      }
    } else {
      telpOnTap();
    }

    EasyLoading.dismiss();
  }
}
