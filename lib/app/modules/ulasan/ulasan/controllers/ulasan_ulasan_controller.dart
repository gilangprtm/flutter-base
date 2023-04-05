import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';

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
  RxBool isLoading = false.obs;

  Future<void> reviewPasien() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();
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
    EasyLoading.dismiss();
  }

  Future<void> summary() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();
    var r = await HttpApi.get('/api/ReviewFaskes/Summary');
    if (r.success) {
      var data = r.body;
      model.value = SummaryModel.fromJson(data);
    } else {
      Helper.dialogWarning(r.message);
    }
    EasyLoading.dismiss();
  }

  void tambahUlasanOnTap() async {
    await dialogRating(controller: ratingCon);
  }

  Future<bool?> dialogRating(
      {String? textConfirm,
      String? textCancel,
      Color? color,
      Function()? backOnPressed,
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
                  size: 50,
                  color: color ?? MahasColors.primary,
                ),
                starCount: 5,
                starSize: 50,
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
              await summary();
              await reviewPasien();
              Get.back(result: true);
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
      Helper.dialogWarning(r.message);
    }
    EasyLoading.dismiss();
  }

  @override
  void onInit() async {
    super.onInit();
    await summary();
    await reviewPasien();
  }
}
