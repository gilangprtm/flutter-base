import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';
import '../controllers/support_faq_controller.dart';

class SupportFaqView extends GetView<SupportFaqController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequently Asked Questions'),
        centerTitle: true,
        backgroundColor: MahasColors.primary,
      ),
      body: Obx(
        () {
          return controller.isLoad.value == false
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.menus.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text(controller.menus[i].title),
                            trailing: IconButton(
                              onPressed: () {
                                controller.menus[i].tap =
                                    !controller.menus[i].tap;
                                controller.tapRefresh();
                              },
                              icon: controller.menus[i].tap == false
                                  ? Icon(
                                      Icons.add,
                                      size: 24.0,
                                    )
                                  : Icon(
                                      Icons.remove,
                                      size: 24.0,
                                    ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: controller.menus[i].tap,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            // height: 100,
                            width: MediaQuery.of(context).size.width - 10,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(
                                  MahasThemes.borderRadius),
                            ),
                            child: Text(controller.menus[i].answer),
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
