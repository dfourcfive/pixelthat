import 'dart:async';
import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:image/image.dart' as i;
import 'dart:ui' as ui;
import 'closet_color_algors.dart';

Uint8List pixelImage(Map<String, dynamic> data) {
  int block_size = data['block_size'];
  File imageFile = data['imageFile'];
  int quality = data['quality'];
  //
  //
  //
  //conver image file to int list
  List<int> intList = List.from(imageFile.readAsBytesSync());
  // decode the array to an image object
  final decodedImage = i.decodeImage(intList);
  //convert and pixlated it
  i.Image pixlated =
      i.pixelate(decodedImage, block_size, mode: i.PixelateMode.upperLeft);
  //encode the image
  final encodedImage = i.encodeJpg(pixlated, quality: quality);
  Uint8List temp = Uint8List.fromList(encodedImage);
  return temp;
}
//
//

Future<Uint8List> applyColorsToImage(Map<String, dynamic> data) async {
  int block_size = data['block_size'];
  Uint8List imageFile = data['bytes'];
  ui.Image image;
  List<int> values = imageFile.buffer.asUint8List();
  log('9bel yahbes ?'); //
  Completer<ui.Image> imageCompleter = new Completer();
  ui.decodeImageFromList(values, (result) {
    imageCompleter.complete(result);
  });
  log('hna yahbes ?'); //
  //
  image = await imageCompleter.future;

  var byteData = await image.toByteData(format: ImageByteFormat.png);
  log('after bytedata ??'); //

  //

  //
  i.Image imagee = i.decodeImage(imageFile.buffer.asUint8List());
  log('or after decoding ??'); //

//
  for (int j = 1; j < imagee.width; j++) {
    for (int i = 1; i < imagee.height; i++) {
      int pixel = imagee.getPixel(i, j);
      byteData.setUint8((i * image.width + j), getFlutterColor(pixel).value);
      log(byteData.toString());
    }
  }
  //

  await Future.delayed(Duration(seconds: 5));
  return byteData.buffer.asUint8List();
}

//
Uint8List applyPalletToImage(Map<String, dynamic> data) {
  //conver image file to int list
  //noOfPixelsPerAxisimagee is block size

  int noOfPixelsPerAxis = data['noOfPixelsPerAxis'];
  int quality = data['quality'];
  List<Color> colors = data['colors'];
  Uint8List bytes = data['bytes'];
  //

  List<int> values = bytes.buffer.asUint8List();
  //
  i.Image image = i.decodeImage(values);
  i.Image newImage = image;
  //

  //

  int width = image.width;
  int height = image.height;

  for (int j = 1; j < width; j = j + 2) {
    for (int i = 1; i < height; i = i + 2) {
      int pixel = image.getPixel(i, j);
      var nearestColor =
          getNearestColorFromChosenPallet(getFlutterColor(pixel), colors);
      newImage.setPixelRgba(
          i, j, nearestColor.red, nearestColor.green, nearestColor.blue, 20);
    }
  }
  final encodedImage = i.encodeJpg(newImage, quality: quality);
  Uint8List temp = Uint8List.fromList(encodedImage);
  return temp;
}

class ImagePixelArtRepo {
  //
  static final ImagePixelArtRepo _instance =
      ImagePixelArtRepo._privateConstructor();
  ImagePixelArtRepo._privateConstructor();
  factory ImagePixelArtRepo() {
    return _instance;
  }

  Uint8List pixelImage(int block_size, File imageFile, int quality) {
    //conver image file to int list
    List<int> intList = List.from(imageFile.readAsBytesSync());
    // decode the array to an image object
    final decodedImage = i.decodeImage(intList);
    //convert and pixlated it
    i.Image pixlated =
        i.pixelate(decodedImage, block_size, mode: i.PixelateMode.average);
    //encode the image
    final encodedImage = i.encodeJpg(pixlated, quality: quality);
    Uint8List temp = Uint8List.fromList(encodedImage);
    return temp;
  }

  Uint8List changeImageColor(int block_size, File imageFile, int quality) {
    //conver image file to int list
    List<int> intList = List.from(imageFile.readAsBytesSync());
    // decode the array to an image object
    final decodedImage = i.decodeImage(intList);
    i.remapColors(decodedImage, red: i.Channel.luminance);
    i.quantize(decodedImage,
        numberOfColors: 2, method: i.QuantizeMethod.octree);
    //i.drawPixel(image, x, y, color);
    //convert and pixlated it
    i.Image pixlated =
        i.pixelate(decodedImage, block_size, mode: i.PixelateMode.average);
    //encode the image
    final encodedImage = i.encodeJpg(pixlated, quality: quality);
    Uint8List temp = Uint8List.fromList(encodedImage);
    return temp;
  }

  List<Color> extractPixelsColors(Uint8List bytes, int noOfPixelsPerAxis) {
    //noOfPixelsPerAxis is block size
    List<Color> colors = [];

    List<int> values = bytes.buffer.asUint8List();
    i.Image image = i.decodeImage(values);

    List<int> pixels = [];

    int width = image.width;
    int height = image.height;

    int xChunk = width ~/ (noOfPixelsPerAxis + 1);
    int yChunk = height ~/ (noOfPixelsPerAxis + 1);

    for (int j = 1; j < noOfPixelsPerAxis + 1; j++) {
      for (int i = 1; i < noOfPixelsPerAxis + 1; i++) {
        int pixel = image.getPixel(xChunk * i, yChunk * j);
        pixels.add(pixel);
        colors.add(getFlutterColor(pixel));
      }
    }
    return colors;
  }

  List<Color> sortColors(List<Color> colors) {
    List<Color> sorted = [];

    sorted.addAll(colors);
    sorted.sort((a, b) => b.computeLuminance().compareTo(a.computeLuminance()));

    return sorted;
  }

  int getTotalPixelsOfImage(File image) {
    //conver image file to int list
    List<int> intList = List.from(image.readAsBytesSync());
    // decode the array to an image object
    final decodedImage = i.decodeImage(intList);
    //convert and pixlated it
    int min = decodedImage.width > decodedImage.height
        ? decodedImage.height
        : decodedImage.width;
    return min;
  }
}

Color getFlutterColor(int abgr) {
  int mycolor = abgrToArgb(abgr);
  return Color(mycolor);
}

//convert abgr to argb
int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
