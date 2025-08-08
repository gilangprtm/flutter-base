import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/mahas_config.dart';
import '../../../mahas/mahas_service.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/notifikasi_model.dart';
import '../../../models/image_slider_model.dart';
import '../../../routes/app_pages.dart';

class HomePremaganaController extends GetxController {
  RxInt current = 0.obs;
  RxBool notifikasi = false.obs;
  final CarouselSliderController imageController = CarouselSliderController();
  String? token;
  static final storage = GetStorage();

  RxList<String> imgList = RxList();

  @override
  void onInit() async {
    await homeProcedure();
    super.onInit();
  }

  imageSlider() {
    final List<Widget> imageSliders = imgList
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: MahasColors.primary,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        )
        .toList();

    return imageSliders;
  }

  void toLogin() {
    Get.toNamed(Routes.LOGIN);
  }

  void toProfile() {
    Get.toNamed(Routes.PROFILE)!.then((value) => {
          getNotifikasi(),
        });
  }

  void toDaftarRawatJalan() {
    Get.toNamed(Routes.DAFTAR_RAWAT_JALAN)!.then((value) => {
          getNotifikasi(),
        });
  }

  void goToArticleDetail() {
    Get.toNamed(Routes.ARTIKEL_DETAIL);
  }

  void toNotif() {
    Get.toNamed(Routes.NOTIFIKASI)!.then((value) => {
          getNotifikasi(),
        });
  }

  void toUlasan() {
    Get.toNamed(Routes.ULASAN_ULASANPAGE);
  }

  void toSupport() {
    Get.toNamed(Routes.SUPPORT);
  }

  void toRiwayat() {
    Get.toNamed(Routes.PASIEN);
  }

  //home procedure start here
  Future getImageSlider() async {
    try {
      var r = await HttpApi.get('/api/FotoSlider');
      if (r.success) {
        late List<ImageSliderModel> sliderList = (json.decode(r.body) as List)
            .map((m) => ImageSliderModel.fromDynamic(m))
            .toList();
        for (var e in sliderList) {
          imgList.add(e.photoURL!);
        }
      } else {
        bool error = MahasService.isInternetCausedError(r.message.toString());
        Helper.errorToast(message: !error ? r.message.toString() : null);
      }
    } catch (e) {
      Helper.errorToast(message: e.toString());
    }
  }

  Future getNotifikasi() async {
    try {
      var r =
          await HttpApi.get('/api/Notifikasi?userId=${auth.currentUser!.uid}');
      if (r.success) {
        List<NotifikasiModel> listNotif = [];
        final data = json.decode(r.body);
        listNotif.clear();
        var datas = data['Data'];
        for (var e in datas) {
          listNotif.add(NotifikasiModel.fromDynamic(e));
        }
        var j = 0;
        for (var i = 0; i < listNotif.length; i++) {
          var item = listNotif[i];
          if (item.dibaca == false) {
            notifikasi.value = true;
            j += 1;
          } else if (j == 0) {
            notifikasi.value = false;
          }
        }
        for (var i = 0; i < listNotif.length; i++) {
          var item = listNotif[i];
          if (item.dibaca == false && item.judul == 'Jadwal Praktek Ditunda' ||
              item.dibaca == false &&
                  item.judul == 'Jadwal Praktek Dibatalkan') {
            Helper.dialogWarning(item.pesan);
            dibaca(item.kodeunik!);
          }
        }
      } else {
        bool error = MahasService.isInternetCausedError(r.message.toString());
        Helper.errorToast(message: !error ? r.message.toString() : null);
      }
    } catch (e) {
      Helper.errorToast(message: e.toString());
    }
  }
  //home procedure end here

  Future launchWebsite(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.platformDefault,
    )) {
      throw Helper.dialogWarning('Could not launch $url');
    }
  }

  void dibaca(String kodeunik) async {
    final body = {};
    final url =
        '/api/Notifikasi/TerbacaByKodeUnik?userId=${MahasConfig.profile!.userIdHaimed}&kodeUnik=$kodeunik';
    await HttpApi.patch(
      url,
      body: body,
    );
  }

  Future homeProcedure() async {
    await getImageSlider();
    await getNotifikasi();
    await versionCheck();
    if (EasyLoading.isShow) EasyLoading.dismiss();
  }

  Future<void> versionCheck() async {
    final updateLater = storage.read('update_later');
    final now = DateTime.now();
    final updateLaterDate =
        updateLater == null ? null : DateTime.parse(updateLater);
    String versi =
        "${MahasConfig.packageInfo!.version}+${MahasConfig.packageInfo!.buildNumber}";
    if (!kIsWeb) {
      if ((!kIsWeb && updateLaterDate?.isAfter(now) == false) ||
          updateLater == null) {
        if (Platform.isIOS || Platform.isAndroid) {
          if (versi != MahasConfig.updateAppValues.version) {
            final r = await Helper.dialogUpdate(
                harusUpdate: MahasConfig.updateAppValues.mustUpdate ?? false,
                versiTerbaru: MahasConfig.updateAppValues.version ?? "");
            if (r == true) {
              await launchUrl(
                      Uri.parse(MahasConfig.updateAppValues.urlUpdate ?? ""),
                      mode: LaunchMode.externalApplication)
                  .then((value) => {
                        if (Platform.isAndroid)
                          {
                            SystemNavigator.pop(),
                          }
                        else if (Platform.isIOS)
                          {
                            exit(0),
                          }
                      });
            } else {
              storage.write(
                  'update_later',
                  now
                      .add(Duration(
                          days:
                              MahasConfig.updateAppValues.dismissDuration ?? 7))
                      .toString());
            }
          }
        }
      }
    }
  }
}
