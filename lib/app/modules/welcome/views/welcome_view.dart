import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "HaiMed RS Bhayangkara",
          body: "Selamat datang di Aplikasi HaiMed RS Bhayangkara",
          image: Image.asset(
            "assets/images/logo.png",
            width: 100.0,
          ),
        ),
        PageViewModel(
          title: "Jadwal Dokter",
          body: "Dapat melihat jadwal praktek dokter dengan mudah dan cepat",
          image: Image.asset(
            "assets/images/logo.png",
            width: 100.0,
          ),
        ),
        PageViewModel(
          title: "Reservasi",
          body: "Dapat melakukan reservasi dan mendapat nomor antrian",
          image: Image.asset(
            "assets/images/logo.png",
            width: 100.0,
          ),
        ),
      ],
      onDone: () {
        controller.onStarted();
      },
      onSkip: () {
        controller.onSkip();
      },
      showSkipButton: true,
      showBackButton: false,
      showDoneButton: true,
      showNextButton: true,
      dotsFlex: 3,
      back: Icon(
        Icons.arrow_back,
        color: Colors.amber,
      ),
      skip: Text(
        "Lewati",
        style: const TextStyle(
          color: Colors.amber,
        ),
      ),
      next: Icon(
        Icons.arrow_forward,
        color: Colors.amber,
      ),
      done: Text(
        "Mulai",
        style: const TextStyle(
          color: Colors.amber,
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
        activeColor: Colors.amber,
      ),
    );
  }
}
