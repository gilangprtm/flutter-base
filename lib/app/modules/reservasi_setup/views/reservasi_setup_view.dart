import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mahas/components/inputs/input_datetime_component.dart';
import '../../../mahas/components/inputs/input_text_component.dart';
import '../../../mahas/components/pages/setup_page_component.dart';
import '../controllers/reservasi_setup_controller.dart';

class ReservasiSetupView extends GetView<ReservasiSetupController> {
  @override
  Widget build(BuildContext context) {
    return SetupPageComponent(
      controller: controller.formCon,
      title: 'Reservasi',
      children: () => [
        InputTextComponent(
          label: 'Nomor Reservasi',
          controller: controller.noReservasi,
          // required: true,
          editable: controller.formCon.editable,
        ),
        InputDatetimeComponent(
          controller: controller.tanggal,
          label: 'Tanggal',
          // required: true,
          editable: controller.formCon.editable,
        ),
        InputTextComponent(
          label: 'NRM',
          controller: controller.nrm,
          // required: true,
          editable: controller.formCon.editable,
        ),
        InputTextComponent(
          label: 'Nama',
          controller: controller.nama,
          // required: true,
          editable: controller.formCon.editable,
        ),
        InputTextComponent(
          label: 'Alamat',
          controller: controller.alamat,
          // required: true,
          editable: controller.formCon.editable,
        ),
        InputDatetimeComponent(
          controller: controller.untukTanggal,
          label: 'Untuk Tanggal',
          // required: true,
          editable: controller.formCon.editable,
        ),
        InputTextComponent(
          label: 'Nama Dokter',
          controller: controller.namaDokter,
          // required: true,
          editable: controller.formCon.editable,
        ),
        InputTextComponent(
          label: 'Nilai Bayar',
          controller: controller.nilaiBayar,
          // required: true,
          editable: controller.formCon.editable,
        ),
        InputTextComponent(
          label: 'Status',
          controller: controller.statusReservasi,
          // required: true,
          editable: controller.formCon.editable,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
