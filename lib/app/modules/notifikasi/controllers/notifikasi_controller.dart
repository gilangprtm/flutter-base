import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../models/notifikasi_model.dart';
import '../../../routes/app_pages.dart';

class NotifikasiController extends GetxController {
  final listCon = ListComponentController<NotifikasiModel>(
    urlApi: (index, filter) =>
        '/api/Notifikasi?userId=${MahasConfig.profile!.userIdHaimed}',
    fromDynamic: NotifikasiModel.fromDynamic,
    allowSearch: false,
  );

  itemOnTab(dynamic model, int tipe, String judul, String pesan, bool dibaca,
      String kodeunik) {
    Get.toNamed(
      Routes.NOTIFIKASI_DETAIL,
      arguments: {
        'model': model,
        'tipenotifikasi': tipe,
        'judul': judul,
        'pesan': pesan,
        'dibaca': dibaca,
        'kodeunik': kodeunik,
      },
    )?.then((value) {
      listCon.refresh();
    });
  }
}
