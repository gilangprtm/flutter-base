import 'dart:convert';

class ImageSliderModel {
  String? id;
  String? photoURL;

  ImageSliderModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ImageSliderModel fromDynamic(dynamic dynamicData) {
    final model = ImageSliderModel();

    model.id = dynamicData['ID'];
    model.photoURL = dynamicData['PhotoURL'];

    return model;
  }
}
