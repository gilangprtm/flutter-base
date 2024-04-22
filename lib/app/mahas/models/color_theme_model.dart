import 'dart:convert';

class ColorThemeModel {
  String? primary;
  String? danger;
  String? warning;

  ColorThemeModel();

  static ColorThemeModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ColorThemeModel fromDynamic(dynamic dynamicData) {
    final model = ColorThemeModel();

    model.primary = dynamicData['primary'];
    model.danger = dynamicData['danger'];
    model.warning = dynamicData['warning'];

    return model;
  }

  factory ColorThemeModel.mapFromJson(Map<String, dynamic> json) {
    return ColorThemeModel.fromDynamic(json);
  }

  Map<String, dynamic> toJson() {
    return {"primary": primary, "danger": danger, "warning": warning};
  }
}
