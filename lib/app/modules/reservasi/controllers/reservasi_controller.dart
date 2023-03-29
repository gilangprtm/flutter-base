// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../models/reservasi_model.dart';

class ReservasiController extends GetxController {
  late ListComponentController<ReservasiModel> listCon;
  var pasienId;

  @override
  void onInit() async {
    pasienId = Get.parameters['pasienId']!;
    super.onInit();
  }

  ListComponentController<ReservasiModel> getReservasi() {
    listCon = ListComponentController<ReservasiModel>(
      urlApi: (index, filter) =>
          '/api/Reservasi?userId=${MahasConfig.profile!.userIdHaimed}&pasienId=$pasienId',
      fromDynamic: ReservasiModel.fromDynamic,
      allowSearch: true,
    );

    update();
    return listCon;
  }

  void toDetail(String idReservasi) {
    Get.toNamed(Routes.DETAIL_RESERVASI,
        parameters: {"reservasiList": idReservasi});
  }
}
