import 'package:cloud_firestore/cloud_firestore.dart';

class ImageCoverModel {
  String gambar;

  ImageCoverModel({required this.gambar});

  ImageCoverModel.fromJson(Map<String, dynamic> json) : gambar = json['gambar'];

  Map<String, dynamic> toJson() {
    return {"gambar": gambar};
  }

  ImageCoverModel.fromSnapshot(DocumentSnapshot documentSnapshot)
      : gambar = documentSnapshot['gambar'];
}
