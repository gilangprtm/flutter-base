import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haimed_getx/app/models/profile_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../mahas/mahas_config.dart';
import '../../../mahas/mahas_service.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/artikel_firebase_model.dart';
import '../../../models/notifikasi_model.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  RxInt current = 0.obs;
  RxBool notifikasi = false.obs;
  final CarouselController imageController = CarouselController();
  String? token;
  static final storage = GetStorage();

  RxList<ArtikelFirestoreModel> artikels = <ArtikelFirestoreModel>[].obs;

  @override
  void onInit() async {
    await homeProcedure();
    super.onInit();
  }

  List<Widget> imageSlider() {
    return MahasConfig.coverImages.map(
      (item) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress != null
                          ? Center(
                              child: Image.asset(
                                "assets/images/iosloading.gif",
                                height: 50,
                                width: 50,
                              ),
                            )
                          : child,
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
            ),
          ),
        );
      },
    ).toList();
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

  void goToArticleDetail(ArtikelFirestoreModel model) {
    Get.toNamed(
      Routes.ARTIKEL_DETAIL,
      arguments: {
        'model': model,
      },
    );
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

  void dibaca(String kodeunik) async {
    final body = {};
    final url =
        '/api/Notifikasi/TerbacaByKodeUnik?userId=${MahasConfig.profile!.userIdHaimed}&kodeUnik=$kodeunik';
    await HttpApi.patch(
      url,
      body: body,
    );
  }

  Future putUser() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();

    var r = await HttpApi.put('/api/User', body: {
      "UserIdHaimed": auth.currentUser!.uid.toString(),
      "Email": auth.currentUser!.email.toString(),
      "Nama": auth.currentUser!.displayName.toString(),
      "Fcm": token.toString(),
    });
    if (r.success) {
      MahasConfig.profile = ProfileModel.fromJson(r.body);
    } else {
      bool error = MahasService.isInternetCausedError(r.message.toString());
      Helper.errorToast(message: !error ? r.message.toString() : null);
    }
    EasyLoading.dismiss();
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

  Future homeProcedure() async {
    await putUser();
    artikels.value = await MahasService().getListArtikelFirestore();
    await getNotifikasi();
    await versionCheck();
  }
}
