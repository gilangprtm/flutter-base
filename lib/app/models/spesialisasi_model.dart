import 'dart:convert';

class GetSpesialisasiModel {
  String? spesialisid;
  String? namaspesialisasi;
  String? spesialisasiURL;

  GetSpesialisasiModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static GetSpesialisasiModel fromDynamic(dynamic dynamicData) {
    final model = GetSpesialisasiModel();

    model.spesialisid = dynamicData['SpesialisId'];
    model.namaspesialisasi = dynamicData['NamaSpesialisasi'];
    model.spesialisasiURL = dynamicData['SpesialisasiURL'];

    return model;
  }
}
