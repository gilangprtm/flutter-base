import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class JadwalpraktekModel {
  DateTime? publishreservasifromjam;
  DateTime? publishreservasitojam;
  String? dokterid;
  String? sectionid;
  String? namasection;
  DateTime? tanggal;
  int? waktuid;
  String? keterangan;
  String? noruang;
  String? dokterpenggantiid;
  String? spesialisname;
  String? namadokter;
  int? jmlantrian;
  bool? cancel;
  int? quotaantrian;
  bool? verified;
  int? noantriansaatini;
  DateTime? fromjam;
  DateTime? tojam;
  String? statuspraktek;
  String? keteranganstatuspraktek;
  String? fotodokter;
  int? noantrianmaxsudahdiperiksa;
  int? jmlpasiensudahdiperiksa;
  int? nomaxpasienterdaftar;
  int? jmlpasienregistrasi;
  int? jmlpasienreservasi;
  bool? isavailable;
  bool? iscanceled;
  bool? ispending;
  bool? isstarted;
  bool? isdone;

  JadwalpraktekModel();

  static fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static JadwalpraktekModel fromDynamic(dynamic dynamicData) {
    final model = JadwalpraktekModel();

    model.publishreservasifromjam =
        MahasFormat.dynamicToDateTime(dynamicData['PublishReservasiFromJam']);
    model.publishreservasitojam =
        MahasFormat.dynamicToDateTime(dynamicData['PublishReservasiToJam']);
    model.dokterid = dynamicData['DokterID'];
    model.sectionid = dynamicData['SectionID'];
    model.namasection = dynamicData['NamaSection'];
    model.tanggal = MahasFormat.dynamicToDateTime(dynamicData['Tanggal']);
    model.waktuid = MahasFormat.dynamicToInt(dynamicData['WaktuID']);
    model.keterangan = dynamicData['Keterangan'];
    model.noruang = dynamicData['NoRuang'];
    model.dokterpenggantiid = dynamicData['DokterPenggantiID'];
    model.spesialisname = dynamicData['SpesialisName'];
    model.namadokter = dynamicData['NamaDOkter'];
    model.jmlantrian = MahasFormat.dynamicToInt(dynamicData['JmlAntrian']);
    model.cancel = MahasFormat.dynamicToBool(dynamicData['Cancel']);
    model.quotaantrian = MahasFormat.dynamicToInt(dynamicData['QuotaAntrian']);
    model.verified = MahasFormat.dynamicToBool(dynamicData['Verified']);
    model.noantriansaatini =
        MahasFormat.dynamicToInt(dynamicData['NoAntrianSaatIni']);
    model.fromjam = MahasFormat.dynamicToDateTime(dynamicData['FromJam']);
    model.tojam = MahasFormat.dynamicToDateTime(dynamicData['ToJam']);
    model.statuspraktek = dynamicData['StatusPraktek'];
    model.keteranganstatuspraktek = dynamicData['KeteranganStatusPraktek'];
    model.fotodokter = dynamicData['FotoDokter'];
    model.noantrianmaxsudahdiperiksa =
        MahasFormat.dynamicToInt(dynamicData['NoAntrianMaxSudahDiperiksa']);
    model.jmlpasiensudahdiperiksa =
        MahasFormat.dynamicToInt(dynamicData['JmlPasienSudahDiperiksa']);
    model.nomaxpasienterdaftar =
        MahasFormat.dynamicToInt(dynamicData['NoMaxPasienTerdaftar']);
    model.jmlpasienregistrasi =
        MahasFormat.dynamicToInt(dynamicData['JmlPasienRegistrasi']);
    model.jmlpasienreservasi =
        MahasFormat.dynamicToInt(dynamicData['JmlPasienReservasi']);
    model.isavailable = MahasFormat.dynamicToBool(dynamicData['IsAvailable']);
    model.iscanceled = MahasFormat.dynamicToBool(dynamicData['IsCanceled']);
    model.ispending = MahasFormat.dynamicToBool(dynamicData['IsPending']);
    model.isstarted = MahasFormat.dynamicToBool(dynamicData['IsStarted']);
    model.isdone = MahasFormat.dynamicToBool(dynamicData['IsDone']);

    return model;
  }
}
