import 'package:get/get.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class UlasanInformasiController extends GetxController {
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
}
