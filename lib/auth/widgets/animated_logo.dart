import 'package:flutter/material.dart';
import 'package:beauty/utils/assets.dart';

class AnimatedLogo extends StatefulWidget {
  final VoidCallback? onEnd;

  const AnimatedLogo({super.key, this.onEnd});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> {
  bool showWidget = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage(Assets.logo), context)
          .then((_) => setState(() => showWidget = true));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!showWidget) return const SizedBox();

    return TweenAnimationBuilder(
      onEnd: widget.onEnd,
      tween: Tween(begin: 20.0, end: 1.0),
      duration: const Duration(milliseconds: 1600),
      curve: Curves.bounceOut,
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: child,
      ),
      child: AnimatedContainer(
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            Assets.logo,
            height: 130,
            width: 130,
          ),
        ),
      ),
    );
  }
}
