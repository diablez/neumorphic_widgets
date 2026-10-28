import 'package:flutter/widgets.dart';

import 'neu_colors.dart';
import 'neu_shadows.dart';

class NeuDecoration extends BoxDecoration {
  NeuDecoration({
    Color? color,
    double radius = 20,
    Border? border,
    bool inset = false, // NEW
    double depth = 7,
    double softness = 2,
    double spread = 0,
    double contrast = 0.3,
  }) : super(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          border: border ??
              (color != null
                  ? Border.all(
                      color: lightenColor(color, 0.17),
                    )
                  : null),
          boxShadow: color != null
              ? NeuShadows.raised(
                  color: color,
                  inset: inset, // ← THIS WAS MISSING
                  depth: depth,
                  softness: softness,
                  spread: spread,
                  contrast: contrast,
                )
              : null,
        );
}
