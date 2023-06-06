import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_service.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/dokter_fav_model.dart';

class DokterFavoriteController extends GetxController {
  final listCon = ListComponentController<DokterfavModel>(
    urlApi: (index, filter) =>
        '/api/DokterFavorit?userId=${MahasConfig.profile!.userIdHaimed}&favorit=true',
    fromDynamic: DokterfavModel.fromDynamic,
    allowSearch: false,
  );

  void deleteOnTap(String index) async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();

    final Object bodyData = {
      "UserIdHaiMed": auth.currentUser!.uid,
      "DokterId": index,
    };
    try {
      var r = await HttpApi.delete("/api/DokterFavorit", body: bodyData);
      if (r.success) {
        listCon.refresh();
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }

    EasyLoading.dismiss();
  }

  void itemOnTab(String id) {
    Get.toNamed(
      Routes.DOKTER_DETAIL_TAB,
      parameters: {
        'id': id.toString(),
      },
    );
  }
}
