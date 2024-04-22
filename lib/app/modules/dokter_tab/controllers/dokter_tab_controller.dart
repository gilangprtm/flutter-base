import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_service.dart';
import 'package:haimed_getx/app/mahas/models/api_result_model.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/dokter_fav_model.dart';

class DokterTabController extends GetxController {
  final listCon = ListComponentController<DokterfavModel>(
    urlApi: (index, filter) =>
        '/api/DokterFavorit?userId=${auth.currentUser!.uid}&filter.pageIndex=$index&namaDokter=$filter',
    fromDynamic: DokterfavModel.fromDynamic,
    allowSearch: true,
  );

  void onSelected(String index, bool favorite) async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();

    final Object bodyData = {
      "UserIdHaiMed": auth.currentUser!.uid,
      "DokterId": index,
    };
    late ApiResultModel r;
    try {
      if (favorite == false) {
        r = await HttpApi.put("/api/DokterFavorit", body: bodyData);
      } else {
        r = await HttpApi.delete("/api/DokterFavorit", body: bodyData);
      }

      if (r.success) {
        listCon.refresh();
      } else {
        bool error = MahasService.isInternetCausedError(r.message.toString());
        Helper.errorToast(message: !error ? r.message.toString() : null);
      }
    } catch (e) {
      Helper.errorToast(message: e.toString());
    }

    EasyLoading.dismiss();
  }

  void goToDokterDetail(String id) {
    Get.toNamed(Routes.DOKTER_DETAIL_TAB, parameters: ({"id": id}))!
        .then((value) => {listCon.refresh()});
  }
}
