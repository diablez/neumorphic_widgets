import 'package:flutter/material.dart';

Color darkenColor(Color color, double shadeFactor) {
  return Color.fromRGBO(
    (color.red * (1 - shadeFactor)).round(),
    (color.green * (1 - shadeFactor)).round(),
    (color.blue * (1 - shadeFactor)).round(),
    color.opacity,
  );
}

Color lightenColor(Color color, double tintFactor) {
  return Color.fromRGBO(
    (color.red + (255 - color.red) * tintFactor).round(),
    (color.green + (255 - color.green) * tintFactor).round(),
    (color.blue + (255 - color.blue) * tintFactor).round(),
    color.opacity,
  );
}
