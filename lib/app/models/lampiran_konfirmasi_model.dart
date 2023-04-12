import 'dart:convert';

class LampirankonfirmasikedatanganModel {
  String? noreservasi;
  String? kodeunik;
  String? namaspesialisasi;
  String? urlfotodokter;

  LampirankonfirmasikedatanganModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static LampirankonfirmasikedatanganModel fromDynamic(dynamic dynamicData) {
    final model = LampirankonfirmasikedatanganModel();

    model.noreservasi = dynamicData['noReservasi'];
    model.kodeunik = dynamicData['kodeUnik'];
    model.namaspesialisasi = dynamicData['namaSpesialisasi'];
    model.urlfotodokter = dynamicData['urlFotoDokter'];

    return model;
  }
}
