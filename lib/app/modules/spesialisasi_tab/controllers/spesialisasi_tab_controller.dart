import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/http_api.dart';
import '../../../models/spesialisasi_model.dart';

class SpesialisasiTabController extends GetxController {
  final listCon = ListComponentController<GetSpesialisasiModel>(
    urlApi: (index, filter) =>
        '/api/Spesialisasi?filter.pageIndex=$index&namaSpesialisasi=$filter',
    fromDynamic: GetSpesialisasiModel.fromDynamic,
    allowSearch: true,
  );

  final List<SpesialisasiModel> spesialisasiList = [];
  TextEditingController searchCon = TextEditingController();

  RxString judul = "".obs;
  var spesialisasiCon = RxList<GetSpesialisasiModel>();

  @override
  void onInit() async {
    addSpesialisasiList();
    // await getSpesialisasi();
    super.onInit();
  }

  Future getSpesialisasi() async {
    if (EasyLoading.isShow) return;
    await EasyLoading.show();

    try {
      var r = await HttpApi.get("/api/Spesialisasi");
      if (r.success) {
        final datas = json.decode(r.body);
        final data = datas['Data'];
        spesialisasiCon.clear();
        for (var e in data) {
          spesialisasiCon.add(GetSpesialisasiModel.fromDynamic(e));
        }
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }
    EasyLoading.dismiss();
  }

  void goToDetailPage(String id, String judul) {
    Get.toNamed(
      Routes.SPESIALISASI_DETAIL_TAB,
      parameters: {"id": id, "judul": judul},
    );
  }

  void toDetailPage() {
    Get.toNamed(
      Routes.SPESIALISASI_DETAIL_TAB,
      parameters: {"judul": judul.value},
    );
  }

  void addSpesialisasiList() {
    spesialisasiList.add(
      SpesialisasiModel(
        "Anak",
        "assets/images/ic_poli_anak.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Bedah",
        "assets/images/ic_poli_bedah_saraf.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "DOKPOL (SKBN, Visum, Ass, Narkoba, Rehab)",
        "assets/images/ic_poli_default.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Gigi & Oral",
        "assets/images/ic_poli_gigi.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Hiperbarik",
        "assets/images/ic_poli_default.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Jantung",
        "assets/images/ic_poli_jantung.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Kandungan",
        "assets/images/ic_poli_obgyn.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Kesehatan Jiwa",
        "assets/images/kesehatanjiwa.png",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Kulit & Kelamin",
        "assets/images/ic_poli_kulitkelamin.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Mata",
        "assets/images/ic_poli_mata.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Poli MCU",
        "assets/images/ic_poli_mcu.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Ortopedi",
        "assets/images/ic_poli_ortopedi.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Paru",
        "assets/images/ic_poli_paru.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Patologi Klinik",
        "assets/images/ic_poli_default.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Penyakit Dalam",
        "assets/images/ic_poli_interna.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Psikolog",
        "assets/images/ic_poli_default.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Rehabilitasi Medik",
        "assets/images/ic_poli_default.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Saraf",
        "assets/images/bedahsaraf.jpeg",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "THT",
        "assets/images/ic_poli_tht.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Umum",
        "assets/images/ic_poli_umum.PNG",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Urologi",
        "assets/images/Urologi.png",
        toDetailPage,
      ),
    );
    spesialisasiList.add(
      SpesialisasiModel(
        "Vaksin Center",
        "assets/images/ic_poli_nurse_station.PNG",
        toDetailPage,
      ),
    );
  }
}

class SpesialisasiModel {
  final String title;
  final String icon;
  final GestureTapCallback onTab;

  SpesialisasiModel(this.title, this.icon, this.onTab);
}
