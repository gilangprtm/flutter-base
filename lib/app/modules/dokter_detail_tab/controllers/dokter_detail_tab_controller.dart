import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/others/empty_component.dart';
import 'package:haimed_getx/app/mahas/services/http_api.dart';
import 'package:haimed_getx/app/models/jadwal_praktek_model.dart';
import 'package:haimed_getx/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_colors.dart';
import '../../../mahas/services/helper.dart';
import '../../../mahas/services/mahas_format.dart';
import '../../../models/dokter_detail_model.dart';

class DokterDetailTabController extends GetxController {
  late List<PraktekExpand> praktekExpand;
  Rx<DateTime> focusDate = DateTime.now().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxString dokterID = "".obs;
  RxBool noData = false.obs;
  Rx<DokterdetailModel> dokterCon = DokterdetailModel().obs;
  var jadwalPraktekCon = RxList<JadwalpraktekModel>();
  var eventData = <JadwalpraktekModel>[].obs;
  RxList<JadwalpraktekModel> eventCard = <JadwalpraktekModel>[].obs;

  @override
  void onInit() async {
    praktekExpand = generateItems(2);
    dokterID.value = Get.parameters['id']!;
    await getDataDokter(dokterID.value).then(
      (value) async => await getJadwalPraktek(dokterID.value, DateTime.now()),
    );
    onDaySelected(DateTime.now(), DateTime.now());
    super.onInit();
  }

  Future getDataDokter(String id) async {
    if (EasyLoading.isShow) return;
    await EasyLoading.show();

    try {
      var r = await HttpApi.get("/api/Dokter/$id");
      if (r.success) {
        DokterdetailModel res = DokterdetailModel.fromJson(r.body);
        dokterCon.value = res;
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }
    EasyLoading.dismiss();
  }

  Future getJadwalPraktek(String id, DateTime date) async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    await EasyLoading.show();
    DateTime firstDayCurrentMonth = DateTime.utc(date.year, date.month, 1);
    DateTime lastDayCurrentMonth =
        DateTime.utc(date.year, date.month + 1).subtract(Duration(days: 1));
    try {
      var r = await HttpApi.get(
          "/api/JadwalPraktek?dariTanggal=$firstDayCurrentMonth&sampaiTanggal=$lastDayCurrentMonth&dokterId=$id");

      if (r.success) {
        final datas = json.decode(r.body);
        final data = datas['Data'];
        jadwalPraktekCon.clear();
        for (var e in data) {
          jadwalPraktekCon.add(JadwalpraktekModel.fromDynamic(e));
        }
        if (eventData.isNotEmpty) {
          eventData.clear();
        }
        eventData.addAll(jadwalPraktekCon.where((e) => e.tanggal != null));
        if (eventData.isEmpty) {
          noData.value = true;
        }
      } else {
        Helper.dialogWarning(r.message);
      }
    } catch (e) {
      Helper.dialogWarning(e.toString());
    }
    EasyLoading.dismiss();
  }

  @override
  void onClose() {}
  List<PraktekExpand> generateItems(int numberOfItems) {
    return List.generate(
      numberOfItems,
      (int index) {
        return PraktekExpand(
            header: index == 0 ? "Kalender Praktek" : "Jadwal Praktek",
            body: index == 0 ? calendarView() : jadwalPraktek(),
            isExpanded: true.obs);
      },
    );
  }

  void toDokterKonfirmasi(String dokterID, String tanggal, String sectionID,
      String waktuID, String namaSection) {
    Get.toNamed(
      Routes.DOKTER_KONFIRMASI_TAB,
      parameters: {
        'dokterID': dokterID,
        'tanggal': tanggal,
        'sectionID': sectionID,
        'waktuID': waktuID,
        'namaSection': namaSection
      },
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDate.value = selectedDay;
    focusDate.value = focusedDay;

    if (selectedDate.value
        .isBefore(DateTime.now().subtract(Duration(days: 1)))) {
      eventCard.clear();
    } else {
      if (eventCard.isNotEmpty) {
        eventCard.clear();
      }
      eventCard.value =
          eventData.where((e) => e.tanggal!.day == selectedDay.day).toList();
    }
  }

  Widget calendarView() {
    return Container(
      color: MahasColors.darkwhite,
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: 320,
        width: Get.width,
        child: Material(
          elevation: 3,
          color: MahasColors.light,
          borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
          child: Obx(
            () => eventData.isEmpty && noData.isFalse
                ? Center(
                    child: CircularProgressIndicator(
                      color: MahasColors.primary,
                    ),
                  )
                : eventData.isNotEmpty || noData.isTrue
                    ? TableCalendar<JadwalpraktekModel>(
                        eventLoader: (day) => eventData
                            .where((event) => isSameDay(event.tanggal!, day))
                            .toList(),
                        rowHeight: 40,
                        daysOfWeekHeight: 30,
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: MahasThemes.h2,
                          weekendStyle: MahasThemes.h2,
                          dowTextFormatter: (date, locale) =>
                              DateFormat.E(locale).format(date)[0],
                        ),
                        currentDay: DateTime.now(),
                        headerStyle: HeaderStyle(
                          titleTextStyle: TextStyle(
                            color: MahasColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                          titleCentered: true,
                          formatButtonVisible: false,
                          leftChevronVisible: false,
                          rightChevronVisible: false,
                        ),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: CalendarStyle(
                          markerDecoration: BoxDecoration(
                              color: MahasColors.green, shape: BoxShape.circle),
                          todayTextStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: MahasColors.light),
                          defaultTextStyle: MahasThemes.normal,
                          selectedTextStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: MahasColors.light),
                          holidayTextStyle: MahasThemes.normal,
                          weekendTextStyle: MahasThemes.normal,
                          outsideTextStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: MahasColors.light),
                          todayDecoration: const BoxDecoration(
                              color: MahasColors.red, shape: BoxShape.circle),
                          selectedDecoration: const BoxDecoration(
                              color: MahasColors.blueGrey,
                              shape: BoxShape.circle),
                        ),
                        focusedDay: focusDate.value,
                        firstDay: DateTime(focusDate.value.year - 10, 1, 1),
                        lastDay: DateTime(focusDate.value.year + 10, 1, 1),
                        onDaySelected: onDaySelected,
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(selectedDate.value, date);
                        },
                        onPageChanged: (focusedDay) async {
                          await getJadwalPraktek(dokterID.value, focusedDay);
                          focusDate.value = focusedDay;
                        },
                      )
                    : EmptyComponent(),
          ),
        ),
      ),
    );
  }

  Widget jadwalPraktek() {
    return Container(
      color: MahasColors.darkwhite,
      padding: EdgeInsets.all(10),
      child: Obx(
        () => eventCard.isEmpty
            ? SizedBox(height: 100, child: EmptyComponent())
            : ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  height: 5,
                  thickness: 0,
                ),
                itemCount: eventCard.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    toDokterKonfirmasi(
                      eventCard[index].dokterid!,
                      eventCard[index].tanggal!.toString(),
                      eventCard[index].sectionid!,
                      eventCard[index].waktuid!.toString(),
                      eventCard[index].namasection!.toString(),
                    );
                  },
                  child: Material(
                    elevation: 3,
                    color: MahasColors.light,
                    borderRadius:
                        BorderRadius.circular(MahasThemes.borderRadius),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                color: MahasColors.primary,
                                size: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormat("EEEE, dd MMMM yyyy")
                                            .format(eventCard[index].tanggal!),
                                        style: MahasThemes.h2,
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        "${MahasFormat.displayTime(TimeOfDay.fromDateTime(eventCard[index].fromjam!))} - ${MahasFormat.displayTime(TimeOfDay.fromDateTime(eventCard[index].tojam!))}",
                                        style: MahasThemes.h2,
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: MahasColors.primary,
                                size: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "RS. Cendana Premiere",
                                        style: MahasThemes.muted,
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        eventCard[index].spesialisname ?? "",
                                        style: MahasThemes.muted,
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.linear_scale,
                                color: MahasColors.primary,
                                size: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Antrian saat ini nomor ${eventCard[index].noantriansaatini} dari nomor ${eventCard[index].jmlantrian}",
                                        style: MahasThemes.muted,
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class PraktekExpand {
  PraktekExpand({
    this.body,
    this.header,
    this.isExpanded,
  });

  Widget? body;
  String? header;
  RxBool? isExpanded;
}

class Event {
  final String title;
  Event({required this.title});

  @override
  String toString() => title;
}
