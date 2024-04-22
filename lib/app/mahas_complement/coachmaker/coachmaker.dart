library coachmaker;

import 'package:flutter/material.dart';
import 'package:haimed_getx/app/mahas_complement/coachmaker/coachmaker_widgetmain.dart';

//coach model
class CoachModel {
  CoachModel(
      {this.initial,
      this.title,
      this.titleTextStyle,
      this.subtitle,
      this.subtitleTextStyle,
      this.header,
      this.maxWidth,
      this.alignment = Alignment.center,
      this.nextOnTapCallBack,
      this.scrollOptions});

  String? initial;
  String? title;
  TextStyle? titleTextStyle;
  List<dynamic>? subtitle;
  TextStyle? subtitleTextStyle;
  Widget? header;
  double? maxWidth;
  AlignmentGeometry? alignment;
  Future<bool> Function()? nextOnTapCallBack;
  ScrollOptions? scrollOptions;
}

class ScrollOptions {
  ScrollOptions(
      {this.scrollController,
      this.manualHeight,
      this.scrollToIndex,
      this.isLast = false});

  double? manualHeight;
  ScrollController? scrollController;
  int? scrollToIndex;
  bool isLast;
}

//coach button option
class CoachButtonOptions {
  CoachButtonOptions({
    this.skipTitle = 'Skip',
    this.buttonTitle = 'Next',
    this.buttonStyle = const ButtonStyle(),
  });

  String? skipTitle;
  ButtonStyle? skipStyle;
  String? buttonTitle;
  ButtonStyle? buttonStyle;
}

///coach point widget
///
class CoachPoint extends StatelessWidget {
  final String initial;
  final Widget child;
  const CoachPoint({super.key, required this.initial, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: GlobalObjectKey(initial),
      child: child,
    );
  }
}

///enum coach maker control
///
enum CoachMakerControl { none, next, close }

class CoachMaker {
  ///first duration delay
  ///
  final Duration firstDelay;

  ///duration
  ///
  final Duration duration;

  ///x = horizontal
  ///y = vertical
  ///h = height
  ///w = width
  ///
  double x = 0, y = 0, h = 0, w = 0;

  ///overlay block tap
  ///
  OverlayEntry? overlayBlock;

  ///overlay entry variable
  ///
  OverlayEntry? overlayEntry;

  ///curren index initalList
  ///
  int currentIndex = 0;

  ///inital list from coach point
  ///
  final List<CoachModel> initialList;

  ///context
  ///
  final BuildContext context;

  ///skip boolean, you can set false if you want to hide skip button
  ///
  final Function()? skip;

  ///next step button control
  ///
  final CoachMakerControl nextStep;

  ///next step button options
  ///
  final CoachButtonOptions? buttonOptions;

  ///custom widget navigator
  ///
  final Widget Function(Function? onSkip, Function onNext)? customNavigator;

  ///constructor
  ///
  CoachMaker(
    this.context, {
    required this.initialList,
    this.firstDelay = const Duration(milliseconds: 1),
    this.duration = const Duration(seconds: 1),
    this.skip,
    this.nextStep = CoachMakerControl.next,
    this.buttonOptions,
    this.customNavigator,
  });

  ///build overlay block
  ///
  OverlayEntry buildOverlayBlock() {
    return OverlayEntry(builder: (context) {
      ///build widget main
      ///
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
      );
    });
  }

  ///build overlay
  ///
  OverlayEntry buildOverlay() {
    return OverlayEntry(builder: (context) {
      ///build widget main
      ///
      return WidgetMain(
        x: x - 8,
        y: y - 8,
        h: h + 16,
        w: w + 16,
        duration: duration,
        padding: 10,
        buttonOptions: buttonOptions ?? CoachButtonOptions(),
        model: initialList[currentIndex],
        customNavigator: customNavigator,
        onSkip: skip == null
            ? null
            : () {
                removeOverlay();
                overlayBlock?.remove();
                overlayBlock = null;
                skip!();
              },
        onTapNext: () {
          switch (nextStep) {
            case CoachMakerControl.next:
              nextOverlay();
              break;
            case CoachMakerControl.close:
              removeOverlay();
              break;
            case CoachMakerControl.none:
              break;
            default:
          }
        },
      );
    });
  }

  ///method for show overlay
  ///
  void show() {
    try {
      Future.delayed(currentIndex == 0 ? firstDelay : Duration(milliseconds: 1),
          () {
        RenderBox box = GlobalObjectKey(initialList[currentIndex].initial!)
            .currentContext!
            .findRenderObject() as RenderBox;

        Offset position = box.localToGlobal(Offset.zero);
        y = position.dy;
        x = position.dx;
        h = box.size.height;
        w = box.size.width;

        if (overlayEntry == null) {
          if (currentIndex == 0) {
            overlayBlock = buildOverlayBlock();
            Overlay.of(context).insert(overlayBlock!);
          }
          overlayEntry = buildOverlay();
          Overlay.of(context).insert(overlayEntry!);
        }
      });
    } catch (e) {
      overlayBlock?.remove();
      overlayBlock = null;

      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  ///method for remove overlay
  ///
  void removeOverlay() {
    overlayBlock?.remove();
    overlayBlock = null;

    overlayEntry?.remove();
    overlayEntry = null;
  }

  ///method for next overlay
  ///
  void nextOverlay() {
    currentIndex++;
    removeOverlay();
    if (currentIndex < initialList.length) show();
  }
}
