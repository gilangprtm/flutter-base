import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class ReservasiModel {
  String? noreservasi;
  DateTime? tanggal;
  DateTime? jam;
  String? nrm;
  String? nama;
  String? alamat;
  String? phone;
  String? untuksectionid;
  String? untukdokterid;
  DateTime? tanggallahir;
  int? jeniskerjasamaid;
  String? sectionname;
  String? dokterid;
  String? namadokter;
  String? untukhari;
  DateTime? untuktanggal;
  int? waktuid;
  int? nourut;
  String? memo;
  String? noreg;
  bool? registrasi;
  String? nrmAkun;
  String? noruang;
  String? keterangan;
  int? noantriansaatini;
  int? quotaantrian;
  int? noantrianterakhir;
  String? statuspraktek;
  String? keteranganstatuspraktek;
  int? jmlantrian;
  String? statusbayar;
  String? statusperiksa;
  String? penanggunghubungan;
  bool? batal;
  String? mobileuserid;
  String? haimeduserid;
  String? haimedrelasiid;
  String? statusresep;
  String? nobuktipembayaran;
  double? nilaibayar;
  String? keteranganbatal;
  bool? pasienbaru;
  String? spesialisid;
  String? spesialisname;
  String? email;
  String? tipereservasi;
  DateTime? mobiletgllahirpasien;
  String? mobileketerangannrm;
  String? mobileketerangannoanggota;
  String? mobileketerangannorujukan;
  String? mobileketerangankerjasama;
  bool? mobileketeranganpasienbaru;
  bool? mobilestatussudahdiperiksa;
  int? jmlpasiensudahdiperiksa;
  int? nomaxpasienterdaftar;
  bool? mobilenotifikasiaktif;
  String? statusreservasi;

  ReservasiModel();
  ReservasiModel.init(
    this.noreservasi,
    this.tanggal,
    this.jam,
    this.nrm,
    this.nama,
    this.alamat,
    this.phone,
    this.untuksectionid,
    this.untukdokterid,
    this.tanggallahir,
    this.jeniskerjasamaid,
    this.sectionname,
    this.dokterid,
    this.namadokter,
    this.untukhari,
    this.untuktanggal,
    this.waktuid,
    this.nourut,
    this.memo,
    this.noreg,
    this.registrasi,
    this.nrmAkun,
    this.noruang,
    this.keterangan,
    this.noantriansaatini,
    this.quotaantrian,
    this.noantrianterakhir,
    this.statuspraktek,
    this.keteranganstatuspraktek,
    this.jmlantrian,
    this.statusbayar,
    this.statusperiksa,
    this.penanggunghubungan,
    this.batal,
    this.mobileuserid,
    this.haimeduserid,
    this.haimedrelasiid,
    this.statusresep,
    this.nobuktipembayaran,
    this.nilaibayar,
    this.keteranganbatal,
    this.pasienbaru,
    this.spesialisid,
    this.spesialisname,
    this.email,
    this.tipereservasi,
    this.mobiletgllahirpasien,
    this.mobileketerangannrm,
    this.mobileketerangannoanggota,
    this.mobileketerangannorujukan,
    this.mobileketerangankerjasama,
    this.mobileketeranganpasienbaru,
    this.mobilestatussudahdiperiksa,
    this.jmlpasiensudahdiperiksa,
    this.nomaxpasienterdaftar,
    this.mobilenotifikasiaktif,
    this.statusreservasi,
  );

  static ReservasiModel fromJson(String jsonString) {
    final data = json.decode(jsonString);
    return fromDynamic(data);
  }

  static ReservasiModel fromDynamic(dynamic dynamicData) {
    final model = ReservasiModel();

    model.noreservasi = dynamicData['NoReservasi'];
    model.tanggal = MahasFormat.dynamicToDateTime(dynamicData['Tanggal']);
    model.jam = MahasFormat.dynamicToDateTime(dynamicData['Jam']);
    model.nrm = dynamicData['NRM'];
    model.nama = dynamicData['Nama'];
    model.alamat = dynamicData['Alamat'];
    model.phone = dynamicData['Phone'];
    model.untuksectionid = dynamicData['UntukSectionID'];
    model.untukdokterid = dynamicData['UntukDokterID'];
    model.tanggallahir =
        MahasFormat.dynamicToDateTime(dynamicData['TanggalLahir']);
    model.jeniskerjasamaid =
        MahasFormat.dynamicToInt(dynamicData['JenisKerjasamaID']);
    model.sectionname = dynamicData['SectionName'];
    model.dokterid = dynamicData['DokterID'];
    model.namadokter = dynamicData['NamaDOkter'];
    model.untukhari = dynamicData['UntukHari'];
    model.untuktanggal =
        MahasFormat.dynamicToDateTime(dynamicData['UntukTanggal']);
    model.waktuid = MahasFormat.dynamicToInt(dynamicData['WaktuID']);
    model.nourut = MahasFormat.dynamicToInt(dynamicData['NoUrut']);
    model.memo = dynamicData['Memo'];
    model.noreg = dynamicData['NoReg'];
    model.registrasi = MahasFormat.dynamicToBool(dynamicData['Registrasi']);
    model.nrmAkun = dynamicData['NRM_AKUN'];
    model.noruang = dynamicData['NoRuang'];
    model.keterangan = dynamicData['Keterangan'];
    model.noantriansaatini =
        MahasFormat.dynamicToInt(dynamicData['NoAntrianSaatIni']);
    model.quotaantrian = MahasFormat.dynamicToInt(dynamicData['QuotaAntrian']);
    model.noantrianterakhir =
        MahasFormat.dynamicToInt(dynamicData['NoAntrianTerakhir']);
    model.statuspraktek = dynamicData['StatusPraktek'];
    model.keteranganstatuspraktek = dynamicData['KeteranganStatusPraktek'];
    model.jmlantrian = MahasFormat.dynamicToInt(dynamicData['JmlAntrian']);
    model.statusbayar = dynamicData['StatusBayar'];
    model.statusperiksa = dynamicData['StatusPeriksa'];
    model.penanggunghubungan = dynamicData['PenanggungHubungan'];
    model.batal = MahasFormat.dynamicToBool(dynamicData['Batal']);
    model.mobileuserid = dynamicData['MobileUserId'];
    model.haimeduserid = dynamicData['HaiMedUserId'];
    model.haimedrelasiid = dynamicData['HaiMedRelasiId'];
    model.statusresep = dynamicData['StatusResep'];
    model.nobuktipembayaran = dynamicData['NoBuktiPembayaran'];
    model.nilaibayar = MahasFormat.dynamicToDouble(dynamicData['NilaiBayar']);
    model.keteranganbatal = dynamicData['KeteranganBatal'];
    model.pasienbaru = MahasFormat.dynamicToBool(dynamicData['PasienBaru']);
    model.spesialisid = dynamicData['SpesialisID'];
    model.spesialisname = dynamicData['SpesialisName'];
    model.email = dynamicData['Email'];
    model.tipereservasi = dynamicData['TipeReservasi'];
    model.mobiletgllahirpasien =
        MahasFormat.dynamicToDateTime(dynamicData['MobileTglLahirPasien']);
    model.mobileketerangannrm = dynamicData['MobileKeteranganNRM'];
    model.mobileketerangannoanggota = dynamicData['MobileKeteranganNoAnggota'];
    model.mobileketerangannorujukan = dynamicData['MobileKeteranganNoRujukan'];
    model.mobileketerangankerjasama = dynamicData['MobileKeteranganKerjasama'];
    model.mobileketeranganpasienbaru =
        MahasFormat.dynamicToBool(dynamicData['MobileKeteranganPasienBaru']);
    model.mobilestatussudahdiperiksa =
        MahasFormat.dynamicToBool(dynamicData['MobileStatusSudahDiperiksa']);
    model.jmlpasiensudahdiperiksa =
        MahasFormat.dynamicToInt(dynamicData['JmlPasienSudahDiperiksa']);
    model.nomaxpasienterdaftar =
        MahasFormat.dynamicToInt(dynamicData['NoMaxPasienTerdaftar']);
    model.mobilenotifikasiaktif =
        MahasFormat.dynamicToBool(dynamicData['MobileNotifikasiAktif']);
    model.statusreservasi = dynamicData['StatusReservasi'];

    return model;
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    final ReservasiModel model = ReservasiModel();
    data['NoReservasi'] = model.noreservasi;
    data['Tanggal'] = model.tanggal;
    data['Jam'] = model.jam;
    data['NRM'] = model.nrm;
    data['Nama'] = model.nama;
    data['Alamat'] = model.alamat;
    data['Phone'] = model.phone;
    data['UntukSectionID'] = model.untuksectionid;
    data['UntukDokterID'] = model.untukdokterid;
    data['TanggalLahir'] = model.tanggallahir;
    data['JenisKerjasamaID'] = model.jeniskerjasamaid;
    data['SectionName'] = model.sectionname;
    data['DokterID'] = model.dokterid;
    data['NamaDOkter'] = model.namadokter;
    data['UntukHari'] = model.untukhari;
    data['UntukTanggal'] = model.untuktanggal;
    data['WaktuID'] = model.waktuid;
    data['NoUrut'] = model.nourut;
    data['Memo'] = model.memo;
    data['NoReg'] = model.noreg;
    data['Registrasi'] = model.registrasi;
    data['NRM_AKUN'] = model.nrmAkun;
    data['NoRuang'] = model.noruang;
    data['Keterangan'] = model.keterangan;
    data['NoAntrianSaatIni'] = model.noantriansaatini;
    data['QuotaAntrian'] = model.quotaantrian;
    data['NoAntrianTerakhir'] = model.noantrianterakhir;
    data['StatusPraktek'] = model.statuspraktek;
    data['KeteranganStatusPraktek'] = model.keteranganstatuspraktek;
    data['JmlAntrian'] = model.jmlantrian;
    data['StatusBayar'] = model.statusbayar;
    data['StatusPeriksa'] = model.statusperiksa;
    data['PenanggungHubungan'] = model.penanggunghubungan;
    data['Batal'] = model.batal;
    data['MobileUserId'] = model.mobileuserid;
    data['HaiMedUserId'] = model.haimeduserid;
    data['HaiMedRelasiId'] = model.haimedrelasiid;
    data['StatusResep'] = model.statusresep;
    data['NoBuktiPembayaran'] = model.nobuktipembayaran;
    data['NilaiBayar'] = model.nilaibayar;
    data['KeteranganBatal'] = model.keteranganbatal;
    data['PasienBaru'] = model.pasienbaru;
    data['SpesialisID'] = model.spesialisid;
    data['SpesialisName'] = model.spesialisname;
    data['Email'] = model.email;
    data['TipeReservasi'] = model.tipereservasi;
    data['MobileTglLahirPasien'] = model.mobiletgllahirpasien;
    data['MobileKeteranganNRM'] = model.mobileketerangannrm;
    data['MobileKeteranganNoAnggota'] = model.mobileketerangannoanggota;
    data['MobileKeteranganNoRujukan'] = model.mobileketerangannorujukan;
    data['MobileKeteranganKerjasama'] = model.mobileketerangankerjasama;
    data['MobileKeteranganPasienBaru'] = model.mobileketeranganpasienbaru;
    data['MobileStatusSudahDiperiksa'] = model.mobilestatussudahdiperiksa;
    data['JmlPasienSudahDiperiksa'] = model.jmlpasiensudahdiperiksa;
    data['NoMaxPasienTerdaftar'] = model.nomaxpasienterdaftar;
    data['MobileNotifikasiAktif'] = model.mobilenotifikasiaktif;
    data['StatusReservasi'] = model.statusreservasi;
    return data;
  }

}
