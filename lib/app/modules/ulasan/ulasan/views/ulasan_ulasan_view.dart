import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/others/shimmer_component.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';
import 'package:intl/intl.dart';

import '../../../../mahas/components/mahas_themes.dart';
import '../../../../mahas/components/others/rating_summary.dart';
import '../controllers/ulasan_ulasan_controller.dart';

class UlasanUlasanView extends GetView<UlasanUlasanController> {
  final UlasanUlasanController c = Get.put(UlasanUlasanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
                ),
                child: RatingSummary(
                  counter: c.model.value!.jumlahvoter ?? 0,
                  average: c.model.value!.bintang!,
                  counterFiveStars: c.model.value!.bintang5!,
                  counterFourStars: c.model.value!.bintang4!,
                  counterThreeStars: c.model.value!.bintang3!,
                  counterTwoStars: c.model.value!.bintang2!,
                  counterOneStars: c.model.value!.bintang1!,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Obx(
                () => Container(
                  child: c.isLoading.value
                      ? ShimmerComponent()
                      : ListView.separated(
                          itemCount: c.models.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 4.0,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            var item = c.models[index];
                            return Container(
                              decoration: const BoxDecoration(
                                  // color: Colors.blue,
                                  ),
                              child: SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        "assets/images/Doctor.png",
                                        height: 50.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: SizedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    // height: 30,
                                                    width: 150,
                                                    child: Text(
                                                      item.namauser ?? "Anonim",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      // maxLines: 2,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          child:
                                                              RatingBarIndicator(
                                                            rating: item
                                                                .bintang!
                                                                .toDouble(),
                                                            itemSize: 15,
                                                            unratedColor:
                                                                MahasColors
                                                                    .grey,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(DateFormat(
                                                                  "dd/MM/yyyy")
                                                              .format(item
                                                                  .tanggal!)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(item.review ?? ""),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Visibility(
                                            visible: item.balasan != null,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Admin",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      item.balasan ?? "text",
                                                      style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
