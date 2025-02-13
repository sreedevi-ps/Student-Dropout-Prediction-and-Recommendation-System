import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRouting {
  static void go({
    required Widget screen,
    FlexifyRouteAnimations animation = FlexifyRouteAnimations.slide,
  }) {
    Flexify.go(
      screen,
      animation: animation,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  static void goRemove({required Widget screen}) {
    Flexify.goRemove(
      screen,
      animation: FlexifyRouteAnimations.slide,
      duration: const Duration(milliseconds: 500),
    );
  }

  static void goRemoveAll(
      {required Widget screen, required BuildContext context}) {
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (route) => false);

    Flexify.goRemoveAll(
      screen,
      animation: FlexifyRouteAnimations.slide,
      duration: const Duration(milliseconds: 500),
    );
  }

  //push and remove all the previous routes

  static void back() {
    Flexify.back();
  }
}
