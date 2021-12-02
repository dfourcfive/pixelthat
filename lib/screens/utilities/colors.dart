import 'dart:ui';

import 'package:palette/palette.dart';

List<Color> generateColors() {
  List<Color> colors = [];
  final colorPalette = ColorPalette(<ColorModel>[
    RgbColor(0, 0, 0), // Black
    RgbColor(144, 144, 144), // Grey
    RgbColor(255, 255, 255), // White
    RgbColor(255, 0, 0), // Red
    RgbColor(0, 255, 0), // Green
    RgbColor(0, 0, 255), // Blue
    RgbColor(255, 255, 0), // Yellow
    RgbColor(0, 255, 255), // Cyan
    RgbColor(255, 0, 255), // Magenta
  ]);

  colorPalette.colors.forEach((e) {
    colors.add(Color.fromRGBO(e.toRgbColor().red, e.toRgbColor().green,
        e.toRgbColor().blue, e.toRgbColor().opacity));
  });
  return colors;
}
