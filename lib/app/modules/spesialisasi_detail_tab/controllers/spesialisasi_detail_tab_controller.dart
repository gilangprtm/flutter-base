import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../models/jadwal_praktek_model.dart';
import '../../../routes/app_pages.dart';

class SpesialisasiDetailTabController extends GetxController {
  late ListComponentController<JadwalpraktekModel> listCon;
  late String title;
  late String id;
  TextEditingController searchCon = TextEditingController();
  Rx<DateTime> dateButton = DateTime.now().obs;

  @override
  void onInit() async {
    title = Get.parameters['judul'].toString();
    id = Get.parameters['id'].toString();

    WidgetsBinding.instance.addPostFrameCallback((_) => datePicker());
    super.onInit();
  }

  void toDokterKonfirmasi(
      String dokterID, String tanggal, String sectionID, String waktuID) {
    Get.toNamed(
      Routes.DOKTER_KONFIRMASI_TAB,
      parameters: {
        'dokterID': dokterID,
        'tanggal': tanggal,
        'sectionID': sectionID,
        'waktuID': waktuID,
      },
    );
  }

  ListComponentController<JadwalpraktekModel> getJadwal() {
    listCon = ListComponentController<JadwalpraktekModel>(
      urlApi: (index, filter) =>
          '/api/JadwalPraktek?dariTanggal=${dateButton.value.toString()}&sampaiTanggal=${dateButton.value.toString()}&spesialisasiId=$id&filter.pageIndex=$index',
      fromDynamic: JadwalpraktekModel.fromDynamic,
      allowSearch: true,
    );

    update();
    return listCon;
  }

  datePicker() async {
    return await DatePicker.showDatePicker(
      Get.context!,
      showTitleActions: true,
      minTime: DateTime(1990, 1, 1),
      maxTime: DateTime(2200, 12, 31),
      onConfirm: (date) {
        dateButton.value = date;
        listCon.refresh();
      },
      locale: LocaleType.en,
    );
  }
}
