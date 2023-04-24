import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class BiayasementaraModel {
  String? noreg;
  double? biayasementara;
  double? deposit;

  BiayasementaraModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static BiayasementaraModel fromDynamic(dynamic dynamicData) {
    final model = BiayasementaraModel();

    model.noreg = dynamicData['NoReg'];
    model.biayasementara =
        MahasFormat.dynamicToDouble(dynamicData['BiayaSementara']);
    model.deposit = MahasFormat.dynamicToDouble(dynamicData['Deposit']);

    return model;
  }
}
