import 'package:get_storage/get_storage.dart';
import 'package:haimed_getx/app/mahas/models/color_theme_model.dart';
import 'package:haimed_getx/app/models/faq_model.dart';
import 'package:haimed_getx/app/models/informasi_umum_model.dart';

class MahasStorage {
  static GetStorage box = GetStorage();
  // storage
  static const String coverImages = "cover_images";
  static const String faq = "faq";
  static const String informasiUmum = "informasi_umum";
  static const String themeColor = "theme_color";

  static void clearAll() {
    // final box = GetStorage();
    box.erase();
  }

  // get set
  static void setCoverImages(dynamic value) => _setBase(
        coverImages,
        value,
        expDateInDays: 30,
      );

  static dynamic getCoverImages() => _getBase(coverImages);

  static void setFaq(List<FaqModel>? values) => _setBase(
        faq,
        values?.map((e) => e.toJson()).toList(),
        expDateInDays: 30,
      );

  static List<FaqModel>? getFaq() => _getBases(
        faq,
        fromJson: FaqModel.mapFromJson,
      );

  static void setInformasiUmum(InformasiumumModel? value) => _setBase(
        informasiUmum,
        value?.toJson(),
        expDateInDays: 30,
      );

  static InformasiumumModel? getInformasiUmum() => _getBase<InformasiumumModel>(
        informasiUmum,
        fromJson: InformasiumumModel.mapFromJson,
      );

  static void setColorTheme(ColorThemeModel? value) => _setBase(
        themeColor,
        value?.toJson(),
        expDateInDays: 30,
      );

  static ColorThemeModel? getColorTheme() => _getBase<ColorThemeModel>(
        themeColor,
        fromJson: ColorThemeModel.mapFromJson,
      );

  // private
  static String _getExpName(String name) => "${name}_exp";
  static String _getExpDateInDays(int days) =>
      DateTime.now().add(Duration(days: days)).toIso8601String();

  static T? _getBase<T>(String name,
      {T Function(Map<String, dynamic> json)? fromJson}) {
    // final box = GetStorage();
    var storage = box.read(name);
    if (storage == null) {
      return null;
    }
    var expired = DateTime.parse(box.read(_getExpName(name)));
    if (expired.isBefore(DateTime.now())) {
      return null;
    }
    if (fromJson != null) {
      return fromJson(storage);
    }
    return storage;
  }

  static List<T>? _getBases<T>(String name,
      {T Function(Map<String, dynamic> json)? fromJson}) {
    // final box = GetStorage();
    var storage = box.read(name);
    if (storage == null) {
      return null;
    }
    var expired = DateTime.parse(box.read(_getExpName(name)));
    if (expired.isBefore(DateTime.now())) {
      return null;
    }
    if (fromJson != null) {
      return (storage as List).map((e) => fromJson(e)).toList();
    }
    return storage;
  }

  static void _setBase(String name, dynamic value, {int expDateInDays = 1}) {
    // final box = GetStorage();
    box.write(name, value);
    box.write(
      _getExpName(name),
      value == null ? null : _getExpDateInDays(expDateInDays),
    );
  }
}
