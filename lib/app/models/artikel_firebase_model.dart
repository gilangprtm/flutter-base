import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ArtikelFirestoreModel artikelFirestoreModelFromJson(String str) =>
    ArtikelFirestoreModel.fromJson(json.decode(str));

String artikelFirestoreModelToJson(ArtikelFirestoreModel data) =>
    json.encode(data.toJson());

class ArtikelFirestoreModel {
  ArtikelFirestoreModel({
    this.deskripsi,
    this.image,
    this.link,
    this.tanggal,
    this.title,
  });

  String? deskripsi;
  String? image;
  String? link;
  Timestamp? tanggal;
  String? title;

  factory ArtikelFirestoreModel.fromJson(Map<String, dynamic> json) =>
      ArtikelFirestoreModel(
        deskripsi: json["deskripsi"],
        image: json["image"],
        link: json["link"],
        tanggal: json["tanggal"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "deskripsi": deskripsi,
        "image": image,
        "link": link,
        "tanggal": tanggal,
        "title": title,
      };

  ArtikelFirestoreModel.fromSnapshot(DocumentSnapshot documentSnapshot)
      : deskripsi = documentSnapshot['deskripsi'],
        image = documentSnapshot['image'],
        link = documentSnapshot['link'],
        tanggal = documentSnapshot['tanggal'],
        title = documentSnapshot['title'];
}
