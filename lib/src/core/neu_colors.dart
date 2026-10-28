import 'package:flutter/painting.dart';

Color darkenColor(Color color, double factor) {
  final f = factor.clamp(0.0, 1.0);

  return color.withValues(
    red: color.r * (1 - f),
    green: color.g * (1 - f),
    blue: color.b * (1 - f),
  );
}

Color lightenColor(Color color, double factor) {
  final f = factor.clamp(0.0, 1.0);

  return color.withValues(
    red: color.r + (1 - color.r) * f,
    green: color.g + (1 - color.g) * f,
    blue: color.b + (1 - color.b) * f,
  );
}
