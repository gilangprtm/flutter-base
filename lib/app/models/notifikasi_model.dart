import 'dart:convert';
import '../mahas/services/mahas_format.dart';
import 'jadwal_praktek_model.dart';
import 'lampiran_konfirmasi_model.dart';

class NotifikasiModel {
  int? idnotifikasi;
  DateTime? waktu;
  String? judul;
  String? pesan;
  dynamic lampiran;
  bool? dibaca;
  DateTime? waktudibaca;
  int? tipenotifikasi;
  String? useridhaimed;
  String? namatipe;
  String? kodeunik;

  NotifikasiModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static NotifikasiModel fromDynamic(dynamic dynamicData) {
    final model = NotifikasiModel();

    model.idnotifikasi = MahasFormat.dynamicToInt(dynamicData['IdNotifikasi']);
    model.waktu = MahasFormat.dynamicToDateTime(dynamicData['Waktu']);
    model.judul = dynamicData['Judul'];
    model.pesan = dynamicData['Pesan'];
    model.tipenotifikasi =
        MahasFormat.dynamicToInt(dynamicData['TipeNotifikasi']);
    model.dibaca = MahasFormat.dynamicToBool(dynamicData['Dibaca']);
    model.waktudibaca =
        MahasFormat.dynamicToDateTime(dynamicData['WaktuDibaca']);
    model.useridhaimed = dynamicData['UserIdHaiMed'];
    model.namatipe = dynamicData['NamaTipe'];
    model.kodeunik = dynamicData['KodeUnik'];
    model.lampiran = (dynamicData['TipeNotifikasi'] == 3 ||
            dynamicData['TipeNotifikasi'] == 4)
        ? LampirankonfirmasikedatanganModel.fromJson(dynamicData['Lampiran'])
        : JadwalpraktekModel.fromJson(dynamicData['Lampiran']);
    return model;
  }
}
