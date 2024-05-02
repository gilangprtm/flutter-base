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
  final InputRadioController tipePasienCon = InputRadioController(
    items: [
      RadioButtonItem(text: "Pasien Baru", value: false),
      RadioButtonItem(text: "Pasien Lama", value: true),
    ],
  );
  final InputTextController nrmCon =
      InputTextController(type: InputTextType.nrm);
  final InputTextController noHPCon =
      InputTextController(type: InputTextType.number);

  RxString dokterID = "".obs;
  RxString tanggal = "".obs;
  RxString sectionID = "".obs;
  RxString waktuID = "".obs;
  RxString namaSection = "".obs;
  RxList<PasienModel> pasienList = RxList<PasienModel>();
  var jadwalPraktekModel = JadwalpraktekModel().obs;
  Rx<PasienModel> selectedPasien = PasienModel().obs;

  @override
  void onInit() async {
    dokterID.value = Get.parameters['dokterID']!;
    tanggal.value = Get.parameters['tanggal']!;
    sectionID.value = Get.parameters['sectionID']!;
    waktuID.value = Get.parameters['waktuID']!;
    namaSection.value = Get.parameters['namaSection'] ?? "";
    tipePasienCon.onChanged = (item) {
      nrmCon.value = null;
      update();
    };
    getPhone();
    super.onInit();
  }

  void pasienonChanged(PasienModel? val) {
    selectedPasien.value = val!;
    if (selectedPasien.value.nrm != null) {
      nrmCon.value = selectedPasien.value.nrm;
      tipePasienCon.value = true;
    } else {
      tipePasienCon.value = false;
      nrmCon.value = null;
    }
    update();
  }

  void getPhone() {
    if (auth.currentUser!.phoneNumber != null) {
      noHPCon.value = auth.currentUser!.phoneNumber;
      noHPCon.onChanged = (value) => telpOnTap();
    } else {
      noHPCon.onTap = () => telpOnTap();
    }
  }

  void telpOnTap() {
    Get.toNamed(Routes.PHONE_LOGIN)!.then((value) => {
          getPhone(),
        });
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
        bool error = MahasService.isInternetCausedError(r.message.toString());
        Helper.errorToast(message: !error ? r.message.toString() : null);
      }
    } catch (e) {
      Helper.errorToast(message: e.toString());
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
        final List data = datas['Data'];
        if (data.isNotEmpty) {
          pasienList.clear();
          for (var e in data) {
            pasienList.add(PasienModel.fromDynamic(e));
          }
          namaPasienCon.items = pasienList
              .map<DropdownItem>(
                  (e) => DropdownItem.init(e.nama, e.pasienidhaimed))
              .toList();
          selectedPasien.value = pasienList.first;

          if (selectedPasien.value.nrm != null) {
            nrmCon.value = selectedPasien.value.nrm;
            tipePasienCon.value = true;
          } else {
            tipePasienCon.value = false;
            nrmCon.value = null;
          }
          update();
        }
      } else {
        bool error = MahasService.isInternetCausedError(r.message.toString());
        Helper.errorToast(message: !error ? r.message.toString() : null);
      }
    } catch (e) {
      Helper.errorToast(message: e.toString());
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
          "Alamat": selectedPasien.value.alamat ?? "",
          "Batal": false,
          "NilaiBayar": 0.0,
          "Nama": selectedPasien.value.nama ?? "",
          "UntukTanggal": jadwalPraktekModel.value.tanggal!.toString(),
          "MobileKeteranganPasienBaru": tipePasienCon.value,
          "NRM": nrmCon.value ?? "",
          "UntukDokterID": dokterID.value,
          "UntukSectionID": sectionID.value,
          "NamaSection": namaSection.value,
          "WaktuID": waktuID.value,
          "MobileKeteranganNRM": nrmCon.value ?? "",
          "NIK": selectedPasien.value.nik ?? "",
          "MobileNotifikasiAktif": true,
          "MobileTglLahirPasien": selectedPasien.value.tanggallahir.toString(),
          "TanggalLahir": selectedPasien.value.tanggallahir.toString(),
          "NoUrut": 0,
          "Tanggal": jadwalPraktekModel.value.tanggal!.toString(),
          "HaiMedUserId": auth.currentUser!.uid,
          "HaiMedRelasiId": selectedPasien.value.pasienidhaimed ?? "",
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
            bool error =
                MahasService.isInternetCausedError(res.message.toString());
            if (error) {
              Helper.errorToast();
            } else {
              List<dynamic> data = json.decode(res.message!)['Errors'];
              if (data.isNotEmpty) {
                for (var e in data) {
                  Helper.errorToast(message: e);
                }
              } else {
                Helper.errorToast(message: res.message.toString());
              }
            }
          }
        }
      } catch (e) {
        Helper.errorToast(message: e.toString());
      }
    } else if (selectedPasien.value.nama == null) {
      Helper.dialogWarning("Nama Pasien harus diisi!");
    } else {
      telpOnTap();
    }

    EasyLoading.dismiss();
  }
}
