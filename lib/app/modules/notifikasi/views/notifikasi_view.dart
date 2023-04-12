import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/others/list_component.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../../models/notifikasi_model.dart';
import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        centerTitle: true,
      ),
      body: ListComponent(
        controller: controller.listCon,
        itemBuilder: (NotifikasiModel e) {
          return InkWell(
            onTap: () => controller.itemOnTab(e.lampiran!, e.tipenotifikasi!,
                e.judul!, e.pesan!, e.dibaca!, e.kodeunik!),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
              color: e.dibaca == false
                  ? Colors.blue[50]
                  : MahasColors.backgroundColor,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.judul ?? "Notifikasi",
                            ),
                            Text(
                              MahasFormat.displayDate(e.waktu),
                              style: MahasColors.muted,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          e.pesan!,
                          style: MahasColors.muted,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
