import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class UpdateappvaluesModel {
  String? version;
  bool? mustUpdate;
  String? urlUpdate;
  int? dismissDuration;

  UpdateappvaluesModel();

  static UpdateappvaluesModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static UpdateappvaluesModel fromDynamic(dynamic dynamicData) {
    final model = UpdateappvaluesModel();

    model.version = dynamicData['version'];
    model.mustUpdate = MahasFormat.dynamicToBool(dynamicData['must_update']);
    model.urlUpdate = dynamicData['url_update'];
    model.dismissDuration =
        MahasFormat.dynamicToInt(dynamicData['dismiss_duration']);

    return model;
  }

  factory UpdateappvaluesModel.mapFromJson(Map<String, dynamic> json) {
    return UpdateappvaluesModel.fromDynamic(json);
  }

  Map<String, dynamic> toJson() {
    return {
      "version": version,
      "must_update": mustUpdate,
      "url_update": urlUpdate,
      "dismiss_duration": dismissDuration,
    };
  }
}
