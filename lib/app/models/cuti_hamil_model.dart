import 'dart:convert';

import '../mahas/services/mahas_format.dart';

class CutihamilModel {
  int? id;
  int? iddivisi;
  DateTime? tanggalinput;
  bool? approvekadiv;
  bool? approvemanager;
  int? akakke;
  DateTime? daritanggal;
  DateTime? sampaitanggal;
  String? alasantolak;
  String? pegawairequest;
  String? pegawaikadiv;
  String? pegawaimanager;
  int? idPegawaiKadiv;
  int? idPegawaiManager;

  CutihamilModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static CutihamilModel fromDynamic(dynamic dynamicData) {
    final model = CutihamilModel();

    model.id = dynamicData['id'];
    model.iddivisi = dynamicData['id_Divisi'];
    model.tanggalinput =
        MahasFormat.stringToDateTime(dynamicData['tanggalInput']);
    model.approvekadiv = dynamicData['approveKadiv'];
    model.approvemanager = dynamicData['approveManager'];
    model.akakke = dynamicData['akakKe'];
    model.daritanggal =
        MahasFormat.stringToDateTime(dynamicData['dariTanggal']);
    model.sampaitanggal =
        MahasFormat.stringToDateTime(dynamicData['sampaiTanggal']);
    model.alasantolak = dynamicData['alasanTolak'];
    model.pegawairequest = dynamicData['pegawaiRequest'];
    model.pegawaikadiv = dynamicData['pegawaiKadiv'];
    model.pegawaimanager = dynamicData['pegawaiManager'];
    model.idPegawaiKadiv = dynamicData['id_Pegawai_Kadiv'];
    model.idPegawaiManager = dynamicData['id_Pegawai_Manager'];

    return model;
  }
}
