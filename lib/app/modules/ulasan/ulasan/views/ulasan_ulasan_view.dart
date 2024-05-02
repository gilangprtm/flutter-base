import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/others/empty_component.dart';
import 'package:haimed_getx/app/mahas/components/others/list_component.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import 'package:haimed_getx/app/models/review_model.dart';
import 'package:intl/intl.dart';

import '../../../../mahas/components/mahas_themes.dart';
import '../../../../mahas/components/others/rating_summary.dart';
import '../controllers/ulasan_ulasan_controller.dart';

class UlasanUlasanView extends GetView<UlasanUlasanController> {
  final UlasanUlasanController c = Get.put(UlasanUlasanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
              ),
              child: c.model.value?.jumlahvoter != 0
                  ? GetBuilder<UlasanUlasanController>(
                      builder: (c) => Column(
                        children: [
                          RatingSummary(
                            counter: c.model.value!.jumlahvoter!,
                            average:
                                controller.getAverageReview(c.countStars()),
                            counterFiveStars: c.model.value!.bintang5!,
                            counterFourStars: c.model.value!.bintang4!,
                            counterThreeStars: c.model.value!.bintang3!,
                            counterTwoStars: c.model.value!.bintang2!,
                            counterOneStars: c.model.value!.bintang1!,
                            color: MahasColors.primary,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(),
                              ),
                              TextButton.icon(
                                onPressed: () => controller.tambahUlasanOnTap(),
                                icon: Icon(FontAwesomeIcons.penToSquare),
                                label: Text("Buat Ulasan"),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        EmptyComponent(),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton.icon(
                          onPressed: () => controller.tambahUlasanOnTap(),
                          icon: Icon(FontAwesomeIcons.penToSquare),
                          label: Text("Tambah Ulasan"),
                        )
                      ],
                    ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListComponent(
                controller: controller.ulasanList,
                itemBuilder: (ReviewModel model) {
                  return ListTile(
                    horizontalTitleGap: 5,
                    contentPadding: EdgeInsets.all(5),
                    leading: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        "assets/images/person.png",
                        color: MahasColors.primary,
                        height: 40,
                        fit: BoxFit.fill,
                      ),
                    ),
                    visualDensity: VisualDensity.compact,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  model.namauser ?? "Anonim",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                child: RatingBarIndicator(
                                  rating: model.bintang != null
                                      ? model.bintang!.toDouble()
                                      : 0.0,
                                  itemSize: 15,
                                  unratedColor: MahasColors.grey,
                                  itemBuilder: (context, index) {
                                    return Icon(
                                      Icons.star,
                                      color: MahasColors.primary,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            model.tanggal != null
                                ? DateFormat("dd/MM/yyyy")
                                    .format(model.tanggal!)
                                : "-",
                            style: MahasThemes.muted,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(model.review ?? ""),
                        Visibility(
                          visible: model.balasan != null,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Admin",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  child: HtmlWidget(
                                    model.balasan ?? "",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
