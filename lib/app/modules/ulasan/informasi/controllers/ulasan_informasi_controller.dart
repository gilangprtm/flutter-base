import 'package:coachmaker/coachmaker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class UlasanInformasiController extends GetxController {
  final box = GetStorage();

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
    initial();
    super.onReady();
  }

  void initial() async {
    var result = await box.read("cm_informasi");
    if (result == true) {
    } else {
      coachMaker();
    }
  }

  void coachMaker() async {
    CoachMaker(
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
    ).show();
    await box.write("cm_informasi", true);
  }
}
