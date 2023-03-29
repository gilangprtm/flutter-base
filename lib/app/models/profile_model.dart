import 'dart:convert';

import '../mahas/services/mahas_format.dart';

class ProfileModel {
  int? id;
  String? nama;
  DateTime? tanggalmulaibekerja;
  DateTime? tanggalselesaibekerja;
  String? statusPegawai;
  String? email;
  List<ProfilDivisiModel>? divisi;

  static ProfileModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ProfileModel fromDynamic(dynamic dynamicData) {
    final model = ProfileModel();

    model.id = dynamicData['id'];
    model.nama = dynamicData['nama'];
    model.tanggalmulaibekerja =
        MahasFormat.stringToDateTime(dynamicData['tanggalMulaiBekerja']);
    model.tanggalselesaibekerja =
        MahasFormat.stringToDateTime(dynamicData['tanggalSelesaiBekerja']);
    model.statusPegawai = dynamicData['statusPegawai'];
    model.email = dynamicData['email'];
    if (dynamicData['divisi'] != null) {
      final detailT = dynamicData['divisi'] as List;
      model.divisi = [];
      for (var i = 0; i < detailT.length; i++) {
        model.divisi!.add(ProfilDivisiModel.fromDynamic(detailT[i]));
      }
    }

    return model;
  }
}

class ProfilDivisiModel {
  int? idDivisi;
  String? divisi;
  bool? prioritas;
  bool? sebagaikadiv;
  bool? sebagaimanager;

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static fromDynamic(dynamic dynamicData) {
    final model = ProfilDivisiModel();

    model.idDivisi = dynamicData['id_Divisi'];
    model.divisi = dynamicData['divisi'];
    model.prioritas = dynamicData['prioritas'];
    model.sebagaikadiv = dynamicData['sebagaiKadiv'];
    model.sebagaimanager = dynamicData['sebagaiManager'];

    return model;
  }
}
