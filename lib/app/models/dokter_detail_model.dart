import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class DokterdetailModel {
  String? dokterid;
  String? namadokter;
  String? alamat;
  String? nokontak;
  String? spesialisasiid;
  String? subspesialisasiid;
  bool? tetap;
  bool? active;
  String? spesialisname;
  String? subspesialisname;
  String? kategoriName;
  String? dokteridhaimed;
  String? photourl;

  DokterdetailModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static DokterdetailModel fromDynamic(dynamic dynamicData) {
    final model = DokterdetailModel();

    model.dokterid = dynamicData['DokterID'];
    model.namadokter = dynamicData['NamaDOkter'];
    model.alamat = dynamicData['Alamat'];
    model.nokontak = dynamicData['NoKontak'];
    model.spesialisasiid = dynamicData['SpesialisasiID'];
    model.subspesialisasiid = dynamicData['SubSpesialisasiID'];
    model.tetap = MahasFormat.dynamicToBool(dynamicData['Tetap']);
    model.active = MahasFormat.dynamicToBool(dynamicData['Active']);
    model.spesialisname = dynamicData['SpesialisName'];
    model.subspesialisname = dynamicData['SubSpesialisName'];
    model.kategoriName = dynamicData['Kategori_Name'];
    model.dokteridhaimed = dynamicData['DokterIdHaiMed'];
    model.photourl = dynamicData['PhotoUrl'];

    return model;
  }
}
