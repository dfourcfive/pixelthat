import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_palette/flutter_palette.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixel_border/pixel_border.dart';
import 'package:pixelthat/application/pixel_handler_repo.dart';
import 'package:random_color/random_color.dart';

class HomeScreen extends StatefulWidget {
  File image;
  HomeScreen({Key key, this.image}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File image;
  Uint8List pixlatedd;
  PixelHandlerRepo pixelHandlerRepo = PixelHandlerRepo();
  final ImagePicker _picker = ImagePicker();

  //
  TextEditingController pixelsNumberController = TextEditingController();
  TextEditingController qualityNumberController = TextEditingController();

  //

  @override
  void initState() {
    super.initState();

    pixelsNumberController.text = '60';
    qualityNumberController.text = '100';
  }

  bool isPallet = false;
  List<Color> colors;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Pixel That :D !',
          style: TextStyle(
              fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.normal),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.white,
                Colors.grey,
                Colors.black.withOpacity(0.9)
              ],
                  stops: [
                0.1,
                0.3,
                0.7
              ])),
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Colors.pinkAccent,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 28.0, left: w * 0.1, right: w * 0.1),
                        height: w,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        alignment: Alignment.center,
                        child: pixlatedd != null
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                child: GestureDetector(
                                  onPanDown: (val) {
                                    log(val.localPosition.dx.toString());
                                  },
                                  child: Image.memory(
                                    pixlatedd,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                child: Container(
                                  child: Image.memory(
                                    widget.image.readAsBytesSync(),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                      ),
                      pixlatedd != null ? Container() : Container(),
                      Container(
                        margin: const EdgeInsets.only(top: 38.0, left: 18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pixel numbers :',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 8.0, right: 18.0),
                                    width: 150,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: PixelBorder.shape(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        pixelSize: 8.0,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: pixelsNumberController,
                                      cursorColor: Colors.pinkAccent,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 18),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.pinkAccent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.pinkAccent),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Quality :',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 8.0, right: 18.0),
                                      width: 150,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: PixelBorder.shape(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          pixelSize: 8.0,
                                        ),
                                      ),
                                      child: TextField(
                                        controller: qualityNumberController,
                                        cursorColor: Colors.pinkAccent,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 18),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.pinkAccent),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.pinkAccent),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pallet :',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          enableDrag: true,
                                          isDismissible: true,
                                          isScrollControlled: true,
                                          shape: PixelBorder.shape(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            pixelSize: 8.0,
                                          ),
                                          builder: (context) {
                                            List<Color> pickedColors = [];
                                            List<int> picked = [];
                                            RandomColor _randomColor =
                                                RandomColor();
                                            List<Color> materialColors = [];
                                            //generating colors here
                                            List<ColorModel> colormodels = [];
                                            for (int i = 0;
                                                i < 255;
                                                i = i + 1) {
                                              materialColors.add(
                                                  _randomColor.randomColor());
                                            }
                                            return StatefulBuilder(
                                                builder: (context, setState) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.7,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      child: Center(
                                                        child:
                                                            Text('Colors :)'),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          ScrollConfiguration(
                                                        behavior:
                                                            ScrollBehavior(),
                                                        child:
                                                            GlowingOverscrollIndicator(
                                                          axisDirection:
                                                              AxisDirection
                                                                  .down,
                                                          color:
                                                              Colors.pinkAccent,
                                                          child:
                                                              GridView.builder(
                                                                  itemCount:
                                                                      materialColors
                                                                          .length,
                                                                  gridDelegate:
                                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              4,
                                                                          crossAxisSpacing:
                                                                              4),
                                                                  itemBuilder:
                                                                      (context,
                                                                          i) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        if (picked
                                                                            .contains(i)) {
                                                                          setState(
                                                                              () {
                                                                            picked.remove(i);
                                                                            pickedColors.remove(materialColors[i]);
                                                                          });
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            picked.add(i);
                                                                            pickedColors.add(materialColors[i]);
                                                                          });
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        margin:
                                                                            const EdgeInsets.all(3.0),
                                                                        decoration:
                                                                            ShapeDecoration(
                                                                          color:
                                                                              materialColors[i],
                                                                          shape:
                                                                              PixelBorder.shape(
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                            pixelSize:
                                                                                8.0,
                                                                          ),
                                                                        ),
                                                                        child: picked.contains(i)
                                                                            ? Center(
                                                                                child: Text(
                                                                                  'Picked',
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              )
                                                                            : Container(),
                                                                      ),
                                                                    );
                                                                  }),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        Navigator.pop(context,
                                                            pickedColors);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        height: 50,
                                                        width: 180,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color:
                                                              Colors.pinkAccent,
                                                          shape:
                                                              PixelBorder.shape(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                            pixelSize: 8.0,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'Apply',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                          }).then((value) {
                                        setState(() {
                                          log(value.length.toString());
                                          List<Color> picked_colors =
                                              value ?? [];
                                          if (picked_colors.length != 0) {
                                            isPallet = true;
                                            colors = picked_colors;
                                          }
                                        });
                                      });
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 8.0, right: 18.0),
                                        padding: const EdgeInsets.all(11.0),
                                        width: 150,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: PixelBorder.shape(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            pixelSize: 8.0,
                                          ),
                                        ),
                                        child:
                                            Center(child: Text('pick colors'))),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var tmp = pixlatedd;
                                    if (isPallet) {
                                      tmp = await pixelHandlerRepo
                                          .getCustomizedPixeledImage(
                                        colors,
                                        int.parse(
                                            pixelsNumberController.text ?? '9'),
                                        int.parse(qualityNumberController.text),
                                        widget.image,
                                      );
                                      setState(() {
                                        pixlatedd = tmp;
                                      });
                                    } else {
                                      tmp = await pixelHandlerRepo
                                          .getDefaultPixeledImage(
                                              int.parse(
                                                  pixelsNumberController.text ??
                                                      '9'),
                                              widget.image,
                                              int.parse(qualityNumberController
                                                  .text));
                                      setState(() {
                                        pixlatedd = tmp;
                                      });
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: const EdgeInsets.only(
                                        top: 38.0,
                                        bottom: 18.0,
                                        right: 8.0,
                                        left: 18.0),
                                    height: 50,
                                    width: 130,
                                    decoration: ShapeDecoration(
                                      color: Colors.pinkAccent,
                                      shape: PixelBorder.shape(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        pixelSize: 8.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    try {
                                      if (await Permission.storage
                                          .request()
                                          .isGranted) {
                                        // Either the permission was already granted before or the user just granted it.
                                        final dir =
                                            await getExternalStorageDirectory();

                                        File file = await File(
                                                '${dir.parent.parent.parent.parent.path}/Download/image_pixeldThat_${DateTime.now().toString()}.png')
                                            .create();
                                        List<int> values =
                                            pixlatedd.buffer.asUint8List();
                                        await file.writeAsBytes(values);
                                        var exist = await file.exists();
                                        if (exist) {
                                          log(exist.toString());
                                          log(file.path);
                                          log(file.parent.toString());
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: Container(
                                                  height: 70,
                                                  width: w,
                                                  decoration: ShapeDecoration(
                                                    color: Colors.pinkAccent,
                                                    shape: PixelBorder.shape(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      pixelSize: 8.0,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Image has been saved in the downloads folder',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )));
                                      }
                                    } catch (e) {
                                      log(e.toString());
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: const EdgeInsets.only(
                                        top: 38.0, bottom: 18.0, right: 28.0),
                                    height: 50,
                                    width: 130,
                                    decoration: ShapeDecoration(
                                      color: Colors.pinkAccent,
                                      shape: PixelBorder.shape(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        pixelSize: 8.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Save',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
