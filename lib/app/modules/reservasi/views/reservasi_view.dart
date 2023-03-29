import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reservasi_controller.dart';

class ReservasiView extends GetView<ReservasiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservasi'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 3,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              controller.toDetail();
            },
            child: Card(
              child: ListTile(
                title: const Text("Reservasi"),
                subtitle: const Text("21 02 2023"),
              ),
            ),
          );
        },
      ),
    );
  }
}
