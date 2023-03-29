import 'dart:convert';

class ProfileModel {
  String? userIdHaimed;
  String? email;
  String? nama;
  String? urlGambar;
  String? telepon;

  static ProfileModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ProfileModel fromDynamic(dynamic dynamicData) {
    final model = ProfileModel();

    model.userIdHaimed = dynamicData['UserIdHaimed'];
    model.email = dynamicData['Email'];
    model.nama = dynamicData['Nama'];
    model.urlGambar = dynamicData['UrlGambar'];
    model.telepon = dynamicData['Telepon'];

    return model;
  }
}
