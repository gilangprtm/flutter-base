import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class ReviewModel {
  String? useridhaimed;
  String? review;
  int? bintang;
  DateTime? tanggal;
  bool? aktif;
  int? faskesidhaimed;
  String? namauser;
  String? balasan;

  ReviewModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ReviewModel fromDynamic(dynamic dynamicData) {
    final model = ReviewModel();

    model.useridhaimed = dynamicData['UserIdHaiMed'];
    model.review = dynamicData['Review'];
    model.bintang = MahasFormat.dynamicToInt(dynamicData['Bintang']);
    model.tanggal = MahasFormat.dynamicToDateTime(dynamicData['Tanggal']);
    model.aktif = MahasFormat.dynamicToBool(dynamicData['Aktif']);
    model.faskesidhaimed =
        MahasFormat.dynamicToInt(dynamicData['FaskesIdHaiMed']);
    model.namauser = dynamicData['NamaUser'];
    model.balasan = dynamicData['Balasan'];

    return model;
  }
}
