import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class PasienModel {
  String? pasienidhaimed;
  String? useridhaimed;
  String? nrm;
  String? nama;
  String? alamat;
  String? nik;
  DateTime? tanggallahir;
  String? tempatlahir;
  DateTime? dibuattanggal;
  bool? akunpemilik;
  String? jeniskelamin;

  PasienModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static PasienModel fromDynamic(dynamic dynamicData) {
    final model = PasienModel();

    model.pasienidhaimed = dynamicData['PasienIdHaiMed'];
    model.useridhaimed = dynamicData['UserIdHaiMed'];
    model.nrm = dynamicData['NRM'];
    model.nama = dynamicData['Nama'];
    model.alamat = dynamicData['Alamat'];
    model.nik = dynamicData['NIK'];
    model.tanggallahir =
        MahasFormat.dynamicToDateTime(dynamicData['TanggalLahir']);
    model.tempatlahir = dynamicData['TempatLahir'];
    model.dibuattanggal =
        MahasFormat.dynamicToDateTime(dynamicData['DibuatTanggal']);
    model.akunpemilik = MahasFormat.dynamicToBool(dynamicData['AkunPemilik']);
    model.jeniskelamin = dynamicData['JenisKelamin'];

    return model;
  }
}
