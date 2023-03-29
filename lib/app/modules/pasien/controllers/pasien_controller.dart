import 'package:get/get.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../models/cuti_hamil_model.dart';
import '../../../routes/app_pages.dart';

class PasienController extends GetxController {
  final listCon = ListComponentController<CutihamilModel>(
    urlApi: (index, filter) =>
        '/api/PermintaanJadwal/CutiHamil/List?pageIndex=$index',
    fromDynamic: CutihamilModel.fromDynamic,
    allowSearch: false,
  );

  void addOnPress() {
    Get.toNamed(Routes.PASIEN_SETUP)?.then((value) {
      if (value) {
        listCon.refresh();
      }
    });
  }

  void itemOnTab(int id) {
    Get.toNamed(
      Routes.PASIEN_SETUP,
      parameters: {
        'id': id.toString(),
      },
    )?.then((value) {
      if (value) {
        listCon.refresh();
      }
    });
  }

  void toReservasi() {
    Get.toNamed(Routes.RESERVASI);
  }
}
