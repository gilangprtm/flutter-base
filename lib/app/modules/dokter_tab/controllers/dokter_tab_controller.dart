import 'package:get/get.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../models/dokter_list_model.dart';

class DokterTabController extends GetxController {
  final listCon = ListComponentController<DokterlistModel>(
    urlApi: (index, filter) =>
        // 'https://apps.sanatasystem.net/HaimedSanataDev/api/Dokter?filter.pageIndex=$index',
        '/api/Dokter?filter.pageIndex=$index',
    fromDynamic: DokterlistModel.fromDynamic,
    allowSearch: true,
  );
  RxBool favourite = false.obs;

  void goToDokterDetail(String id) {
    Get.toNamed(Routes.DOKTER_DETAIL_TAB, parameters: ({"id": id}));
  }
}
