import 'package:get/get.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../models/spesialisasi_model.dart';

class SpesialisasiTabController extends GetxController {
  final listCon = ListComponentController<GetSpesialisasiModel>(
    urlApi: (index, filter) =>
        '/api/Spesialisasi?filter.pageIndex=$index&namaSpesialisasi=$filter',
    fromDynamic: GetSpesialisasiModel.fromDynamic,
    allowSearch: true,
  );

  void goToDetailPage(String id, String judul) {
    Get.toNamed(
      Routes.SPESIALISASI_DETAIL_TAB,
      parameters: {"id": id, "judul": judul},
    );
  }
}
