import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/others/list_component.dart';

import '../../../../mahas/components/inputs/input_text_component.dart';
import '../../../../mahas/components/mahas_themes.dart';
import '../../../../mahas/mahas_colors.dart';
import '../../../../mahas/mahas_service.dart';
import '../../../../mahas/services/helper.dart';
import '../../../../mahas/services/http_api.dart';
import '../../../../models/review_model.dart';
import '../../../../models/summary_model.dart';

class UlasanUlasanController extends GetxController {
  final ratingCon = InputTextController(type: InputTextType.paragraf);
  var models = RxList<ReviewModel>();
  var model = Rxn<SummaryModel>();

  final ListComponentController<ReviewModel> ulasanList =
      ListComponentController(
    urlApi: (index, filter) => '/api/ReviewFaskes?pageSize=15&pageIndex=$index',
    fromDynamic: ReviewModel.fromDynamic,
    allowSearch: false,
  );

  Future<void> summary() async {
    var r = await HttpApi.get('/api/ReviewFaskes/Summary');
    if (r.success) {
      var data = r.body;
      model.value = SummaryModel.fromJson(data);
    } else {
      bool error = MahasService.isInternetCausedError(r.message.toString());
      Helper.errorToast(message: !error ? r.message.toString() : null);
    }
  }

  List<int> countStars() {
    List<int> bintang1 = [];
    List<int> bintang2 = [];
    List<int> bintang3 = [];
    List<int> bintang4 = [];
    List<int> bintang5 = [];
    List<int> allStars = [];
    for (var i = 0; i < model.value!.bintang1!; i++) {
      bintang1.add(1);
    }
    for (var i = 0; i < model.value!.bintang2!; i++) {
      bintang2.add(2);
    }
    for (var i = 0; i < model.value!.bintang3!; i++) {
      bintang3.add(3);
    }
    for (var i = 0; i < model.value!.bintang4!; i++) {
      bintang4.add(4);
    }
    for (var i = 0; i < model.value!.bintang5!; i++) {
      bintang5.add(5);
    }

    List<List<int>> datas = [bintang1, bintang2, bintang3, bintang4, bintang5];
    for (var e in datas) {
      allStars.addAll(e);
    }
    return allStars;
  }

  double getAverageReview(List<int> reviewScores) {
    double sum = 0.0;
    for (int i = 0; i < reviewScores.length; i++) {
      sum += reviewScores[i];
    }
    return sum / reviewScores.length;
  }

  void tambahUlasanOnTap() async {
    ratingCon.value = null;
    await dialogRating(controller: ratingCon, isRefreshList: true);
  }

  Future<bool?> dialogRating(
      {String? textConfirm,
      String? textCancel,
      Color? color,
      Function()? backOnPressed,
      bool isRefreshList = false,
      required InputTextController controller}) async {
    RxDouble ratingStars = 0.0.obs;
    return await Get.dialog<bool?>(
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(MahasThemes.borderRadius))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "ULASAN DAN PENILAIAN",
              textAlign: TextAlign.center,
              style: MahasThemes.h2,
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => RatingStars(
                value: ratingStars.value,
                onValueChanged: (v) {
                  ratingStars.value = v;
                },
                starBuilder: (index, color) => Icon(
                  Icons.star_rounded,
                  size: 45,
                  color: color ?? MahasColors.primary,
                ),
                starCount: 5,
                starSize: 45,
                valueLabelColor: MahasColors.grey,
                valueLabelTextStyle: MahasThemes.h3White,
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 0.0,
                maxValueVisibility: false,
                valueLabelVisibility: false,
                animationDuration: Duration(milliseconds: 1000),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                valueLabelMargin: const EdgeInsets.only(right: 10),
                starOffColor: MahasColors.grey,
                starColor: color ?? MahasColors.primary,
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            InputTextComponent(
                label: "Tuliskan ulasan anda", controller: controller)
          ],
        ),
        contentPadding:
            const EdgeInsets.only(bottom: 0, top: 20, right: 20, left: 20),
        actionsPadding:
            const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
        actions: [
          TextButton(
              child: Text(
                textCancel ?? "Tutup",
                style: const TextStyle(
                  color: MahasColors.dark,
                ),
              ),
              onPressed: backOnPressed ??
                  () {
                    Get.back(result: false);
                  }),
          TextButton(
            child: Text(
              textConfirm ?? "Kirim Ulasan",
              style: TextStyle(
                color: color ?? MahasColors.primary,
              ),
            ),
            onPressed: () async {
              await postRating(controller.value, ratingStars.value.toInt());
              Get.back(result: true);
              if (isRefreshList) {
                await summary();
                ulasanList.refresh();
              }
              update();
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> postRating(String review, int bintang) async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();
    var r = await HttpApi.post('/api/ReviewFaskes', body: {
      "UserIdHaiMed": auth.currentUser!.uid,
      "Review": review,
      "Bintang": bintang,
      "FaskesIdHaiMed": 1,
      "NamaUser": auth.currentUser!.displayName,
    });
    if (!r.success) {
      bool error = MahasService.isInternetCausedError(r.message.toString());
      Helper.errorToast(message: !error ? r.message.toString() : null);
    }
    EasyLoading.dismiss();
  }

  @override
  void onInit() async {
    super.onInit();
    await summary();
    countStars();
  }
}
