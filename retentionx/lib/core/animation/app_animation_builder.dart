

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AppAnimationBuilder extends StatelessWidget {
  const AppAnimationBuilder({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        position: 0,
        child: SlideAnimation(
            verticalOffset: 50.0, child: FadeInAnimation(child: child)));
  }
}