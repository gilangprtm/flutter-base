import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

import '../mahas_colors.dart';
import '../components/mahas_themes.dart';

class Helper {
  static Future<bool?> dialogQuestion({
    String? message,
    IconData? icon,
    String? textConfirm,
    String? textCancel,
    Color? color,
  }) async {
    return await Get.dialog<bool?>(
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(MahasThemes.borderRadius))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? FontAwesomeIcons.question,
              color: color ?? MahasColors.primary,
              size: 40,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Text(
              message ?? "",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        contentPadding:
            const EdgeInsets.only(bottom: 0, top: 20, right: 20, left: 20),
        actionsPadding:
            const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
        actions: [
          TextButton(
            child: Text(
              textCancel ?? "Close",
              style: const TextStyle(
                color: MahasColors.dark,
              ),
            ),
            onPressed: () {
              Get.back(result: false);
            },
          ),
          TextButton(
            child: Text(
              textConfirm ?? "OK",
              style: TextStyle(
                color: color ?? MahasColors.primary,
              ),
            ),
            onPressed: () {
              Get.back(result: true);
            },
          ),
        ],
      ),
    );
  }

  static Future<bool?> dialogQuestionWithAction({
    String? message,
    IconData? icon,
    required bool withConfirm,
    String? textConfirm,
    String? textCancel,
    Color? color,
    dynamic actionConfirm,
  }) async {
    return await Get.dialog<bool?>(
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(MahasThemes.borderRadius))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? FontAwesomeIcons.question,
              color: color ?? MahasColors.primary,
              size: 40,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Text(
              message ?? "",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        contentPadding:
            const EdgeInsets.only(bottom: 0, top: 20, right: 20, left: 20),
        actionsPadding:
            const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
        actions: [
          TextButton(
            child: Text(
              textCancel ?? "Close",
              style: const TextStyle(
                color: MahasColors.dark,
              ),
            ),
            onPressed: () {
              Get.back(result: false);
            },
          ),
          withConfirm
              ? TextButton(
                  child: Text(
                    textConfirm ?? "OK",
                    style: TextStyle(
                      color: color ?? MahasColors.primary,
                    ),
                  ),
                  onPressed: () {
                    if (actionConfirm != null) {
                      actionConfirm();
                    } else {
                      Get.back(result: true);
                    }
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }

  static Future<bool?> dialogUpdate({
    required bool harusUpdate,
    required String versiTerbaru,
  }) async {
    return await Get.dialog<bool?>(
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(MahasThemes.borderRadius))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.question,
              color: MahasColors.primary,
              size: 40,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Text(
              "Versi $versiTerbaru sudah tersedia",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        contentPadding:
            const EdgeInsets.only(bottom: 0, top: 20, right: 20, left: 20),
        actionsPadding:
            const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
        actions: [
          TextButton(
            child: Text(
              harusUpdate ? "Tutup" : "Nanti",
              style: const TextStyle(
                color: MahasColors.dark,
              ),
            ),
            onPressed: () {
              if (harusUpdate) {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              } else {
                Get.back(result: false);
              }
            },
          ),
          TextButton(
            child: Text(
              "Unduh Sekarang",
              style: TextStyle(
                color: MahasColors.primary,
              ),
            ),
            onPressed: () {
              Get.back(result: true);
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future dialogWarning(String? message) async {
    await Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.triangleExclamation,
              color: MahasColors.warning,
              size: 40,
            ),
            const Padding(padding: EdgeInsets.all(7)),
            Text(
              textAlign: TextAlign.center,
              message ?? "-",
              style: TextStyle(
                color: MahasColors.warning,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future dialogConnection({
    String? message,
    required dynamic action,
  }) async {
    await Get.dialog(
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.triangleExclamation,
                color: MahasColors.warning,
                size: 40,
              ),
              const Padding(padding: EdgeInsets.all(7)),
              Text(
                textAlign: TextAlign.center,
                message ?? "-",
                style: TextStyle(
                  color: MahasColors.warning,
                ),
              ),
            ],
          ),
          contentPadding:
              const EdgeInsets.only(bottom: 0, top: 20, right: 20, left: 20),
          actionsPadding:
              const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
          actions: [
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(
                  color: MahasColors.primary,
                ),
              ),
              onPressed: () => action(),
            ),
          ],
        ),
        barrierDismissible: false);
  }

  static Future dialogSuccess(String? message) async {
    await Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.checkToSlot,
              color: MahasColors.primary,
              size: 40,
            ),
            const Padding(padding: EdgeInsets.all(7)),
            Text(
              textAlign: TextAlign.center,
              message ?? "-",
              style: TextStyle(
                color: MahasColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future dialogFoto(
      String? fotoUrl, String? fallbackFoto, String? message) async {
    await Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(MahasThemes.borderRadius),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        contentPadding: EdgeInsets.all(0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Get.width * 0.6,
              margin: EdgeInsets.all(20),
              child: Center(
                child: fotoUrl != null
                    ? Image.network(
                        fotoUrl,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 60,
                            width: 60,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: MahasColors.primary,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        fallbackFoto ?? "assets/images/Doctor.png",
                      ),
              ),
            ),
            Container(
              width: Get.width,
              color: MahasColors.primary,
              padding: EdgeInsets.all(5),
              child: Text(
                textAlign: TextAlign.center,
                message ?? "-",
                style: TextStyle(
                  color: MahasColors.light,
                  backgroundColor: MahasColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void errorToast({String? message}) {
    Get.snackbar(
      "Terjadi Kesalahan",
      message ?? 'Pastikan internetmu lancar, cek ulang jaringan di tempatmu',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      backgroundColor: MahasColors.danger,
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      borderRadius: MahasThemes.borderRadius,
      colorText: MahasColors.light,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  static void backOnPress({
    dynamic result,
    bool questionBack = true,
    bool editable = false,
    dynamic parametes,
  }) async {
    if (questionBack && editable) {
      final r = await Helper.dialogQuestion(
        message: 'Anda yakin ingin kembali ?',
        textConfirm: 'Ya',
      );
      if (r != true) return;
    }
    Get.back(result: result);
  }

  static String idGenerator() {
    const uuid = Uuid();
    var r = uuid.v4();
    return r;
  }

  static dynamic modalMenu(List<Widget> children) async {
    return await showCustomModalBottomSheet(
      context: Get.context!,
      builder: (context) => Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(MahasThemes.borderRadius)),
          color: MahasColors.light,
        ),
        child: Column(
          children: children,
        ),
      ),
      containerWidget: (_, animation, child) => SafeArea(
        child: Column(
          children: [Expanded(child: Container()), child],
        ),
      ),
      expand: false,
    );
  }

  static List<DateTime> calculateDaysInterval(
      DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }
}
