import 'dart:convert';

import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_radio_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';

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

  @override
  void onInit() {
    // cekApproval();
    formCon = SetupPageController(
      urlApiGet: (id) => '/api/PermintaanJadwal/CutiHamil/$id',
      urlApiPost: () => '/api/PermintaanJadwal/CutiHamil',
      urlApiPut: (id) => '/api/PermintaanJadwal/CutiHamil/$id',
      // urlApiDelete: (id) => '/api/PermintaanJadwal/CutiHamil/$id',
      // allowDelete: allowED,
      // allowEdit: allowED,
      bodyApi: (id) => {
        // "Id_Divisi": MahasConfig.selectedDivisi,
        // "AkakKe": anakCon.value,
        // "DariTanggal": MahasFormat.dateToString(dariTglCon.value),
        // "SampaiTanggal": MahasFormat.dateToString(sampaiTanggal),
      },
      itemKey: (e) => e['id'],
      itemIdAfterSubmit: (e) => json.decode(e)['id'],
      onBeforeSubmit: () {
        // if (!anakCon.isValid) return false;
        // if (!dariTglCon.isValid) return false;
        // if (!radioCon.isValid) return false;
        // if (anakCon.value < 1) {
        //   Helper.dialogWarning("Cuti Hamil Minimal Kuota \nAnak Ke-1!");
        //   return false;
        // } else if (anakCon.value > 3) {
        //   Helper.dialogWarning("Cuti Hamil Melebihi Kuota \nAnak Ke-3");
        //   return false;
        // }
        // if (radioCon.value == "1 Bulan") {
        //   var today = dariTglCon.value;
        //   sampaiTanggal = today.add(const Duration(days: 30));
        // } else {
        //   var today = dariTglCon.value;
        //   sampaiTanggal = today.add(const Duration(days: 60));
        // }
        return true;
      },
      apiToView: (json) {
        // model = CutihamilModel.fromJson(json);
        // anakCon.value = model.akakke;
        // dariTglCon.value = model.daritanggal;
        // sampaiTglCon.value = model.sampaitanggal;

        // accManager = model.approvemanager;
        // accKadiv = model.approvekadiv;
        // pegawaiKadiv.value = model.pegawaikadiv!;
        // pegawaiManager.value = model.pegawaimanager!;

        // Duration diff = model.sampaitanggal!.difference(model.daritanggal!);
        // if (diff.inDays == 30) {
        //   radioCon.value = "1 Bulan";
        // } else {
        //   radioCon.value = "2 Bulan";
        // }

        // // approval
        // if (allowED == false) {
        //   if ((model.approvekadiv == null &&
        //           model.idPegawaiKadiv == MahasConfig.profile!.id) ||
        //       (model.approvekadiv == true &&
        //           model.approvemanager == null &&
        //           model.idPegawaiManager == MahasConfig.profile!.id)) {
        //     isVisible.value = true;
        //   }
        // }
      },
    );

    super.onInit();
  }
}
