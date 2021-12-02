import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:pixelthat/application/image_pixel_art.dart';

void calculate(int i) {}

class PixelHandlerRepo {
  //
  ImagePixelArtRepo imagePixelArtRepo = ImagePixelArtRepo();

  //
  static final PixelHandlerRepo _instance =
      PixelHandlerRepo._privateConstructor();
  PixelHandlerRepo._privateConstructor();
  factory PixelHandlerRepo() {
    return _instance;
  }
  Future<Uint8List> getDefaultPixeledImage(
      int block_size, File imageFile, int quality) async {
    var imageResult = await compute(pixelImage,
        {'block_size': block_size, 'imageFile': imageFile, 'quality': quality});

    return imageResult;
  }

  Future<Uint8List> getCustomizedPixeledImage(
      List<Color> colors, int block_size, quality, File imageFile) async {
    var imageResult = await compute(pixelImage,
        {'block_size': block_size, 'imageFile': imageFile, 'quality': quality});

    Uint8List pixeledImage = await compute(applyPalletToImage, {
      'quality': quality,
      'colors': colors,
      'bytes': imageResult,
      'noOfPixelsPerAxis': block_size
    });

    return pixeledImage;
  }

  Future<void> dosomething() async {
    await compute(calculate, 5, debugLabel: 'doSomething');
  }

  int getTotalPixels(File image) {
    return imagePixelArtRepo.getTotalPixelsOfImage(image);
  }
}
