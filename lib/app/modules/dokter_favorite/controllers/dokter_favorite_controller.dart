import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../models/dokter_fav_model.dart';

class DokterFavoriteController extends GetxController {
  final listCon = ListComponentController<DokterfavModel>(
    urlApi: (index, filter) =>
        '/api/DokterFavorit?userId=${MahasConfig.profile!.userIdHaimed}&favorit=true',
    fromDynamic: DokterfavModel.fromDynamic,
    allowSearch: false,
  );

  void itemOnTab(String id) {
    Get.toNamed(
      Routes.DOKTER_DETAIL_TAB,
      parameters: {
        'id': id.toString(),
      },
    );
  }
}
