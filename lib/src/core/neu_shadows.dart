import 'dart:math' as math;
import 'package:flutter/painting.dart';

import 'neu_colors.dart';

class NeuShadows {
  const NeuShadows._();

  static List<BoxShadow> raised({
    required Color color,
    bool inset = false,
    double depth = 7,
    double softness = 2,
    double spread = 0,
    double contrast = 0.3,
    double blurCompensation = 0.5,
    double lightAngle = -3 * math.pi / 4,
  }) {
    // Shadow geometry
    final blur = depth * softness;
    final offset = depth + blur * blurCompensation;
    final direction = inset ? -1.0 : 1.0;
    final dx = offset * math.cos(lightAngle);
    final dy = offset * math.sin(lightAngle);

    // Constrain spread
    final minSpread = -depth;
    final maxSpread = math.max(
      minSpread,
      depth - blur * 0.5,
    );

    final effectiveSpread = spread.clamp(minSpread, maxSpread).toDouble();

    // Shadow colour
    final factor = contrast.clamp(0.0, 1.0).toDouble();

    return [
      BoxShadow(
        color: lightenColor(color, factor),
        offset: Offset(dx * direction, dy * direction),
        blurRadius: blur,
        spreadRadius: effectiveSpread,
      ),
      BoxShadow(
        color: darkenColor(color, factor),
        offset: Offset(-dx * direction, -dy * direction),
        blurRadius: blur,
        spreadRadius: effectiveSpread,
      ),
    ];
  }
}
