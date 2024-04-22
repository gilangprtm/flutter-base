import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_datetime_component.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_radio_component.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_text_component.dart';
import 'package:haimed_getx/app/mahas/components/pages/setup_page_component.dart';

class TambahPasienController extends GetxController {
  late SetupPageController formCon;
  final InputTextController namaLengkapCon = InputTextController();
  final InputTextController nikCon =
      InputTextController(type: InputTextType.number);
  final InputTextController tempatLahirCon = InputTextController();
  final InputDatetimeController tanggalLahirCon = InputDatetimeController();
  final InputRadioController jenisKelaminCon = InputRadioController(
    items: [
      RadioButtonItem.simple("Laki-laki"),
      RadioButtonItem.simple("Perempuan"),
    ],
  );
  final InputTextController alamatLengkapCon =
      InputTextController(type: InputTextType.paragraf);

  @override
  void onInit() {
    formCon = SetupPageController(
      allowDelete: true,
      allowEdit: true,
      itemKey: (e) => ['id'],
      itemIdAfterSubmit: (e) => "10",
      apiToView: (json) => {},
      onBeforeSubmit: () {
        if (!namaLengkapCon.isValid) return false;
        if (!nikCon.isValid) return false;
        if (!tempatLahirCon.isValid) return false;
        if (!tanggalLahirCon.isValid) return false;
        if (!jenisKelaminCon.isValid) return false;
        if (!alamatLengkapCon.isValid) return false;
        return true;
      },
    );
    formCon.editable = true;
    super.onInit();
  }
}
