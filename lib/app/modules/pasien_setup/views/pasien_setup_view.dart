import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_radio_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../controllers/pasien_setup_controller.dart';

class PasienSetupView extends GetView<PasienSetupController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.backOnPressed(),
      child: SetupPageComponent(
        controller: controller.formCon,
        title: 'Pasien',
        children: () => [
          InputTextComponent(
            label: 'Nama Lengkap',
            controller: controller.namaCon,
            required: true,
            editable: controller.formCon.editable,
          ),
          InputTextComponent(
            label: 'NIK',
            controller: controller.nikCon,
            required: true,
            editable: controller.formCon.editable,
          ),
          InputTextComponent(
            label: 'Tempat Lahir',
            controller: controller.tempatLahirCon,
            required: true,
            editable: controller.formCon.editable,
          ),
          InputDatetimeComponent(
            controller: controller.dariTglCon,
            label: 'Tanggal Lahir',
            required: true,
            editable: controller.formCon.editable,
          ),
          InputRadioComponent(
            controller: controller.radioCon,
            editable: controller.formCon.editable,
            required: true,
            label: 'Jenis Kelamin',
          ),
          InputTextComponent(
            label: 'Alamat Lengkap',
            controller: controller.alamatCon,
            required: true,
            editable: controller.formCon.editable,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
