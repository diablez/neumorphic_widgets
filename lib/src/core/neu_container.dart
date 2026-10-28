import 'package:flutter/widgets.dart';

import 'neu_decoration.dart';

class NeuContainer extends StatelessWidget {
  const NeuContainer({
    super.key,
    this.child,
    this.color,
    this.radius = 18,
    this.depth = 8.2,
    this.softness = 1.9,
    this.spread = 0.8,
    this.contrast = 0.2,
    this.inset = false,
  });

  final Widget? child;
  final Color? color;
  final double radius;
  final bool inset;
  final double depth;
  final double softness;
  final double spread;
  final double contrast;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: NeuDecoration(
        color: color,
        radius: radius,
        inset: inset, // NEW
        depth: depth,
        softness: softness,
        spread: spread,
        contrast: contrast,
      ),
      child: Center(child: child),
    );
  }
}
