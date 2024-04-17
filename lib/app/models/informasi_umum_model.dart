import 'dart:convert';
import '../mahas/services/mahas_format.dart';

class InformasiumumModel {
	String? namaaplikasi;
	String? alamat;
	double? alamatlat;
	double? alamatlong;
	String? deskripsirumahsakit;
	String? email;
	String? notelp;
	String? urlprivacypolicy;
	String? urltermandcondition;
	String? website;

  InformasiumumModel();

	static InformasiumumModel fromJson(String jsonString) {
		final data = json.decode(jsonString);
		return fromDynamic(data);
	}

	static InformasiumumModel fromDynamic(dynamic dynamicData) {
		final model = InformasiumumModel();

		model.namaaplikasi = dynamicData['namaAplikasi'];
		model.alamat = dynamicData['alamat'];
		model.alamatlat = MahasFormat.dynamicToDouble(dynamicData['alamatLat']);
		model.alamatlong = MahasFormat.dynamicToDouble(dynamicData['alamatlong']);
		model.deskripsirumahsakit = dynamicData['deskripsiRumahSakit'];
		model.email = dynamicData['email'];
		model.notelp = dynamicData['noTelp'];
		model.urlprivacypolicy = dynamicData['urlPrivacyPolicy'];
		model.urltermandcondition = dynamicData['urltermAndCondition'];
		model.website = dynamicData['website'];

		return model;
	}
}
