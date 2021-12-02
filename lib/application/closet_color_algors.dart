import 'dart:ui';

int distance(Color a, Color b) {
  return ((a.red - b.red).abs() +
      (a.green - b.green).abs() +
      (a.blue - b.blue).abs());
}

Color getNearestColorFromChosenPallet(Color color, List<Color> colors) {
  List<int> result = [];
  Map<Color, int> tracker = {};
  int index = 0;
  colors.forEach((e) {
    result.add(distance(color, e));
    tracker[e] = result[index];
    index++;
  });
  result.sort();
  result = result.reversed.toList();
  //
  Color firsColor = colors.first;
  tracker.forEach((key, value) {
    if (value == result.first) {
      firsColor = key;
      return firsColor;
    } else {
      firsColor = key;
    }
  });

  //
  return firsColor ?? colors.first;
}
