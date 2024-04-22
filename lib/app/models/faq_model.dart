import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FaqModel {
  String? question;
  String? answer;
  RxBool tap = false.obs;

  FaqModel();

  static FaqModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static FaqModel fromDynamic(dynamic dynamicData) {
    final model = FaqModel();

    model.question = dynamicData['question'];
    model.answer = dynamicData['answer'];

    return model;
  }

  factory FaqModel.mapFromJson(Map<String, dynamic> json) {
    return FaqModel.fromDynamic(json);
  }

  Map<String, dynamic> toJson() {
    return {"question": question, "answer": answer};
  }
}
