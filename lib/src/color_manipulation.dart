import 'package:flutter/material.dart';

Color darkenColor(Color color, double shadeFactor) {
  final alpha = (color.a * 255).round() / 255;
  return Color.fromRGBO(
    ((color.r * 255).round() * (1 - shadeFactor)).round(),
    ((color.g * 255).round() * (1 - shadeFactor)).round(),
    ((color.b * 255).round() * (1 - shadeFactor)).round(),
    alpha,
  );
}

Color lightenColor(Color color, double tintFactor) {
  final alpha = (color.a * 255).round() / 255;
  final red = (color.r * 255).round();
  final green = (color.g * 255).round();
  final blue = (color.b * 255).round();
  return Color.fromRGBO(
    (red + (255 - red) * tintFactor).round(),
    (green + (255 - green) * tintFactor).round(),
    (blue + (255 - blue) * tintFactor).round(),
    alpha,
  );
}
