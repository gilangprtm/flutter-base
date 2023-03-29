import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class SummaryModel {
  int? faskesid;
  String? namafaskes;
  double? bintang;
  int? bintang1;
  int? bintang2;
  int? bintang3;
  int? bintang4;
  int? bintang5;
  int? bintangtotal;
  int? jumlahvoter;

  SummaryModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static SummaryModel fromDynamic(dynamic dynamicData) {
    final model = SummaryModel();

    model.faskesid = MahasFormat.dynamicToInt(dynamicData['FaskesId']);
    model.namafaskes = dynamicData['NamaFaskes'];
    model.bintang = MahasFormat.dynamicToDouble(dynamicData['Bintang']);
    model.bintang1 = MahasFormat.dynamicToInt(dynamicData['Bintang1']);
    model.bintang2 = MahasFormat.dynamicToInt(dynamicData['Bintang2']);
    model.bintang3 = MahasFormat.dynamicToInt(dynamicData['Bintang3']);
    model.bintang4 = MahasFormat.dynamicToInt(dynamicData['Bintang4']);
    model.bintang5 = MahasFormat.dynamicToInt(dynamicData['Bintang5']);
    model.bintangtotal = MahasFormat.dynamicToInt(dynamicData['BintangTotal']);
    model.jumlahvoter = MahasFormat.dynamicToInt(dynamicData['JumlahVoter']);

    return model;
  }
}
