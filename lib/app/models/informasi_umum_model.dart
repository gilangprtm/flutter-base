import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class InformasiumumModel {
  String? faskesKeyID;
  String? namars;
  String? namaaplikasi;
  String? alamat;
  double? alamatlat;
  double? alamatlong;
  String? deskripsirumahsakit;
  String? email;
  String? notelp;
  String? urlprivacypolicy;
  String? urltermandcondition;
  String? website;

  InformasiumumModel();

  static InformasiumumModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static InformasiumumModel fromDynamic(dynamic dynamicData) {
    final model = InformasiumumModel();

    model.faskesKeyID = dynamicData['faskesKeyID'];
    model.namars = dynamicData['namaRS'];
    model.namaaplikasi = dynamicData['namaAplikasi'];
    model.alamat = dynamicData['alamat'];
    model.alamatlat = MahasFormat.dynamicToDouble(dynamicData['alamatLat']);
    model.alamatlong = MahasFormat.dynamicToDouble(dynamicData['alamatlong']);
    model.deskripsirumahsakit = dynamicData['deskripsiRumahSakit'];
    model.email = dynamicData['email'];
    model.notelp = dynamicData['noTelp'];
    model.urlprivacypolicy = dynamicData['urlPrivacyPolicy'];
    model.urltermandcondition = dynamicData['urltermAndCondition'];
    model.website = dynamicData['website'];

    return model;
  }

  factory InformasiumumModel.mapFromJson(Map<String, dynamic> json) {
    return InformasiumumModel.fromDynamic(json);
  }

  Map<String, dynamic> toJson() {
    return {
      "faskesKeyID": faskesKeyID,
      "namaRS": namars,
      "namaAplikasi": namaaplikasi,
      "alamat": alamat,
      "alamatLat": alamatlat,
      "alamatlong": alamatlong,
      "deskripsiRumahSakit": deskripsirumahsakit,
      "email": email,
      "noTelp": notelp,
      "urlPrivacyPolicy": urlprivacypolicy,
      "urltermAndCondition": urltermandcondition,
      "website": website
    };
  }
}
