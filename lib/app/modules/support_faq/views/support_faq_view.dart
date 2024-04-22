import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_config.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';
import '../controllers/support_faq_controller.dart';

class SupportFaqView extends GetView<SupportFaqController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pertanyaan Yang Sering Diajukan'),
        centerTitle: true,
        backgroundColor: MahasColors.primary,
      ),
      body: ListView.builder(
        itemCount: MahasConfig.faq.length,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int i) {
          var item = MahasConfig.faq[i];
          return Obx(
            () => Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text(item.question ?? ""),
                    trailing: IconButton(
                      onPressed: () {
                        item.tap.toggle();
                      },
                      icon: item.tap.value == false
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
                  visible: item.tap.value,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius:
                          BorderRadius.circular(MahasThemes.borderRadius),
                    ),
                    child: HtmlWidget(item.answer ?? ""),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
