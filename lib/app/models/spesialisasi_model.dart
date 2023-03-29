import 'dart:convert';

class GetSpesialisasiModel {
  String? spesialisid;
  String? namaspesialisasi;
  String? spesialisasiidhaimed;

  GetSpesialisasiModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static GetSpesialisasiModel fromDynamic(dynamic dynamicData) {
    final model = GetSpesialisasiModel();

    model.spesialisid = dynamicData['SpesialisId'];
    model.namaspesialisasi = dynamicData['NamaSpesialisasi'];
    model.spesialisasiidhaimed = dynamicData['SpesialisasiIdHaiMed'];

    return model;
  }
}
