import 'package:coachmaker/coachmaker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../models/pasien_model.dart';
import '../../../routes/app_pages.dart';

class PasienController extends GetxController {
  final box = GetStorage();

  final listCon = ListComponentController<PasienModel>(
    urlApi: (index, filter) =>
        '/api/PasienHaiMed?userId=${MahasConfig.profile!.userIdHaimed}',
    fromDynamic: PasienModel.fromDynamic,
    allowSearch: false,
  );

  void addOnPress() {
    Get.toNamed(Routes.PASIEN_SETUP)!.then((value) => {
          listCon.refresh(),
        });
  }

  void itemOnTab(String id) {
    Get.toNamed(
      Routes.PASIEN_SETUP,
      parameters: {
        'id': id.toString(),
      },
    )!
        .then((value) => {
              listCon.refresh(),
            });
  }

  void toPasienSetup(String id) {
    Get.toNamed(
      Routes.PASIEN_SETUP,
      parameters: {
        'id': id.toString(),
      },
    )!
        .then((value) => {
              listCon.refresh(),
            });
  }

  @override
  void onReady() {
    initial();
    super.onReady();
  }

  void toReservasi(String id) {
    Get.toNamed(
      Routes.RESERVASI,
      parameters: {
        'pasienId': id.toString(),
      },
    );
  }

  void initial() async {
    var result = await box.read("cm_pasien");
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
          title: 'Tambah Pasien',
          maxWidth: 400,
          subtitle: [
            'Tombol untuk melakukan penambahan pasien baru',
          ],
        ),
      ],
    ).show();
    await box.write("cm_pasien", true);
  }
}
