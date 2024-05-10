import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas_complement/coachmaker/coachmaker.dart';
import '../../../models/pasien_model.dart';
import '../../../routes/app_pages.dart';

class PasienController extends GetxController {
  final box = GetStorage();

  CoachMaker cMaker = CoachMaker(
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
    customNavigator: (onSkip, onNext) {
      return Row(
        children: [
          SizedBox(),
          TextButton(
            onPressed: () {
              final box = GetStorage();
              box.write("cm_pasien", true);
              onNext();
            },
            child: Text(
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
    coachMaker();
    listCon.refresh();
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

  void coachMaker() async {
    var result = await box.read("cm_pasien");
    if (result != true) {
      cMaker.show();
    }
  }

  @override
  void onClose() {
    cMaker.removeOverlay();
    super.onClose();
  }
}
