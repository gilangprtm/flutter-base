import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../models/pasien_model.dart';
import '../../../routes/app_pages.dart';

class PasienController extends GetxController {
  final listCon = ListComponentController<PasienModel>(
    urlApi: (index, filter) =>
        '/api/PasienHaiMed?userId=${MahasConfig.profile!.userIdHaimed}',
    fromDynamic: PasienModel.fromDynamic,
    allowSearch: false,
  );

  void addOnPress() {
    Get.toNamed(Routes.PASIEN_SETUP);
  }

  void itemOnTab(String id) {
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

  void toPasienSetup(String id) {
    Get.toNamed(
      Routes.PASIEN_SETUP,
      parameters: {
        'id': id.toString(),
      },
    );
  }

  void toReservasi(String id) {
    Get.toNamed(
      Routes.RESERVASI,
      parameters: {
        'pasienId': id.toString(),
      },
    );
  }
}
