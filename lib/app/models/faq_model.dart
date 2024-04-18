import 'dart:convert';

class FaqModel {
  String? question;
  String? answer;

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
