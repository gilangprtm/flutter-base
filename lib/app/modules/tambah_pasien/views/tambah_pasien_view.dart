import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_datetime_component.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_radio_component.dart';
import 'package:haimed_getx/app/mahas/components/inputs/input_text_component.dart';
import 'package:haimed_getx/app/mahas/components/pages/setup_page_component.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';

import '../controllers/tambah_pasien_controller.dart';

class TambahPasienView extends GetView<TambahPasienController> {
  const TambahPasienView({super.key});
  @override
  Widget build(BuildContext context) {
    return SetupPageComponent(
      title: "Tambah Pasien",
      controller: controller.formCon,
      children: () => [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 35,
              color: MahasColors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: InputTextComponent(
                controller: controller.namaLengkapCon,
                placeHolder: "Nama Lengkap",
                required: true,
                editable: controller.formCon.editable,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.card_travel_rounded,
              size: 35,
              color: MahasColors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: InputTextComponent(
                controller: controller.nikCon,
                placeHolder: "Nomor Induk Kewarganegaraan (NIK)",
                required: true,
                editable: controller.formCon.editable,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_city_rounded,
              size: 35,
              color: MahasColors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: InputTextComponent(
                controller: controller.tempatLahirCon,
                placeHolder: "Tempat Lahir",
                required: true,
                editable: controller.formCon.editable,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.date_range_rounded,
              size: 35,
              color: MahasColors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: InputDatetimeComponent(
                controller: controller.tanggalLahirCon,
                label: "Tanggal Lahir",
                required: true,
                editable: controller.formCon.editable,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person_rounded,
              size: 35,
              color: MahasColors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: InputRadioComponent(
                controller: controller.jenisKelaminCon,
                label: "Jenis Kelamin",
                required: true,
                editable: controller.formCon.editable,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_history,
              size: 35,
              color: MahasColors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: InputTextComponent(
                controller: controller.alamatLengkapCon,
                label: "Alamat Lengkap",
                required: true,
                editable: controller.formCon.editable,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
