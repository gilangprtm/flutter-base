import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifikasi_detail_controller.dart';

class NotifikasiDetailView extends GetView<NotifikasiDetailController> {
  const NotifikasiDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifikasi"),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(child: Text("Spesialisasi")),
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Container(
                                      child: Text(
                                    ": ${controller.spesialisasi}",
                                    style: TextStyle(),
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Container(child: Text("Status")),
                                  SizedBox(
                                    width: 52,
                                  ),
                                  Container(
                                      child: Text(
                                    ": ${controller.judul}",
                                    style: TextStyle(),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  // color: HexColor(GlobalColor.COLOR_PRIMARY_2),
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              )),
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Keterangan",
                                // style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(controller.pesan!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
