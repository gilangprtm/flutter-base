import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../mahas_complement/coachmaker/coachmaker.dart';

class UlasanInformasiController extends GetxController {
  final box = GetStorage();

  CoachMaker cMaker = CoachMaker(
    Get.context!,
    initialList: [
      CoachModel(
        initial: '1',
        title: 'Reservasi',
        maxWidth: 400,
        subtitle: [
          'Tombol alternatif untuk melakukan reservasi',
        ],
      ),
    ],
    customNavigator: (onSkip, onNext) {
      return Row(
        children: [
          SizedBox(),
          TextButton(
            onPressed: () {
              final box = GetStorage();
              box.write("cm_informasi", true);
              onNext();
            },
            child:  Text(
              "Lanjut",
              style: TextStyle(
                color: MahasColors.primary,
              ),
            ),
          ),
        ],
      );
    },
  );

  void toReservasi() {
    Get.toNamed(Routes.DAFTAR_RAWAT_JALAN);
  }

  Future<void> launchWebsite(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> lauchPhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  @override
  void onReady() {
    coachMaker();
    super.onReady();
  }

  void coachMaker() async {
    var result = await box.read("cm_informasi");
    if (result == true) {
    } else {
      cMaker.show();
    }
  }

  @override
  void onClose() {
    cMaker.removeOverlay();
    super.onClose();
  }
}
