import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/components/mahas_themes.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../mahas/mahas_colors.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: MahasColors.primary,
      pages: [
        PageViewModel(
          bodyWidget: Text(
            "Selamat datang di Aplikasi HaiMed \nRS Cendana Premier",
            style: MahasThemes.welcomeTitle.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          title: "",
          image: Image.asset(
            "assets/images/logo-nobg.png",
            width: 250,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            "Jadwal Dokter",
            style: MahasThemes.welcomeTitle,
            textAlign: TextAlign.center,
          ),
          bodyWidget: Text(
            "Dapat melihat jadwal praktek dokter dengan mudah dan cepat",
            style: MahasThemes.welcomeBody,
            textAlign: TextAlign.center,
          ),
          image: Image.asset(
            "assets/images/logo-nobg.png",
            width: 200,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            "Reservasi",
            style: MahasThemes.welcomeTitle,
            textAlign: TextAlign.center,
          ),
          bodyWidget: Text(
            "Dapat melakukan reservasi dan mendapat nomor antrian",
            style: MahasThemes.welcomeBody,
            textAlign: TextAlign.center,
          ),
          image: Image.asset(
            "assets/images/logo-nobg.png",
            width: 200,
          ),
        ),
      ],
      onDone: () {
        controller.onStarted();
      },
      onSkip: () {
        controller.onStarted();
      },
      showSkipButton: true,
      showBackButton: false,
      showDoneButton: true,
      showNextButton: true,
      dotsFlex: 3,
      back: Icon(
        Icons.arrow_back,
        color: MahasColors.light,
      ),
      skip: Text(
        "Lewati",
        style: const TextStyle(
          color: MahasColors.light,
        ),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: MahasColors.light,
      ),
      done: Text(
        "Mulai",
        style: const TextStyle(
          color: MahasColors.light,
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: Size(10, 19),
        color: Colors.grey,
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        activeColor: MahasColors.light,
      ),
    );
  }
}
