import 'dart:convert';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/mahas/services/mahas_format.dart';

import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_radio_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../../../models/pasien_model.dart';
import '../../pasien/controllers/pasien_controller.dart';

class PasienSetupController extends GetxController {
  late SetupPageController formCon;
  final namaCon = InputTextController();
  final nikCon = InputTextController(
    type: InputTextType.number,
  );
  final tempatLahirCon = InputTextController();
  final dariTglCon = InputDatetimeController();
  final radioCon = InputRadioController(
    items: [
      RadioButtonItem.simple("Laki-Laki"),
      RadioButtonItem.simple("Perempuan"),
    ],
  );
  final alamatCon = InputTextController();
  String? pasienIdHaimed;
  late PasienController pasienList;
  RxString getData = ''.obs;

  @override
  void onInit() {
    pasienList = Get.isRegistered<PasienController>()
        ? Get.find<PasienController>()
        : Get.put(PasienController());
    getData.value = Get.parameters['getData'] ?? '';
    formCon = SetupPageController(
      urlApiGet: (id) => '/api/PasienHaiMed/$id',
      urlApiPost: () => '/api/PasienHaiMed',
      urlApiPut: (id) => '/api/PasienHaiMed',
      urlApiDelete: (id) => '/api/PasienHaiMed',
      allowDelete: false,
      autoBack: true,
      bodyApi: (id) => {
        "PasienIdHaiMed": pasienIdHaimed,
        "UserIdHaiMed": MahasConfig.profile!.userIdHaimed,
        "Nama": namaCon.value,
        "Alamat": alamatCon.value,
        "NIK": nikCon.value,
        "TanggalLahir": MahasFormat.dateToString(dariTglCon.value),
        "TempatLahir": tempatLahirCon.value,
        "DibuatTanggal": MahasFormat.dateToString(DateTime.now()),
        "AkunPemilik": false,
        "JenisKelamin": radioCon.value == "Laki-Laki" ? "M" : "F",
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['PasienIdHaiMed'],
      onBeforeSubmit: () {
        if (!namaCon.isValid) return false;
        if (!nikCon.isValid) return false;
        if (!tempatLahirCon.isValid) return false;
        if (!dariTglCon.isValid) return false;
        if (!radioCon.isValid) return false;
        if (!alamatCon.isValid) return false;

        return true;
      },
      apiToView: (json) {
        PasienModel model = PasienModel.fromJson(json);
        namaCon.value = model.nama;
        dariTglCon.value = model.tanggallahir;
        nikCon.value = model.nik;
        tempatLahirCon.value = model.tempatlahir;
        alamatCon.value = model.alamat!;
        if (model.jeniskelamin == "M") {
          radioCon.value = "Laki-Laki";
        } else {
          radioCon.value = "Perempuan";
        }
        if (model.pasienidhaimed!.isNotEmpty) {
          pasienIdHaimed = model.pasienidhaimed;
        }
      },
    );
    super.onInit();
  }
}
