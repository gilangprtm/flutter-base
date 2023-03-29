import 'dart:convert';

import 'package:get/get.dart';

import '../../../../mahas/services/helper.dart';
import '../../../../mahas/services/http_api.dart';
import '../../../../models/review_model.dart';
import '../../../../models/summary_model.dart';

class UlasanUlasanController extends GetxController {
  var models = RxList<ReviewModel>();
  var model = Rxn<SummaryModel>();
  var isLoading = false.obs;

  Future<void> reviewPasien() async {
    if (isLoading.isTrue) return;
    isLoading.value = true;
    var r = await HttpApi.get('/api/ReviewFaskes');
    if (r.success) {
      final datas = json.decode(r.body);
      final data = datas['Data'];
      models.clear();
      for (var e in data) {
        models.add(ReviewModel.fromDynamic(e));
      }
    } else {
      Helper.dialogWarning(r.message);
    }
    isLoading.value = false;
  }

  Future<void> summary() async {
    var r = await HttpApi.get('/api/ReviewFaskes/Summary');
    if (r.success) {
      var data = r.body;
      model.value = SummaryModel.fromJson(data);
    } else {
      Helper.dialogWarning(r.message);
    }
  }

  @override
  void onInit() {
    super.onInit();
    summary();
    reviewPasien();
  }
}
