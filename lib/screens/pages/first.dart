import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pixel_border/pixel_border.dart';
import 'package:pixelthat/screens/pages/home.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  //picker image
  final ImagePicker _picker = ImagePicker();

  //
  Timer timer;
  Timer timerr;
  bool animateCloudOne = false;
  bool animateStarOne = false;
  //
  AnimationController _controller;
  Animation<double> animation;

  void animateClouds() async {
    timer = Timer.periodic(
        Duration(seconds: 2),
        (Timer t) => (setState(() {
              animateCloudOne = !animateCloudOne;
            })));
  }

  void animateStars() async {
    timerr = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => (setState(() {
              animateStarOne = !animateStarOne;
            })));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animateClouds();
    animateStars();
    //
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
      animationBehavior: AnimationBehavior.preserve,
    );
    animation = Tween(begin: -80.0, end: 400.0).animate(_controller);
    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
    timerr.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
        child: Stack(
          children: [
            AnimatedPositioned(
                top: animateCloudOne ? 100 : 120,
                left: 19,
                duration: Duration(seconds: 2),
                child: Container(
                  child: Image(
                    height: 80,
                    image: AssetImage('assets/cloud3.png'),
                  ),
                )),
            AnimatedPositioned(
                top: animateCloudOne ? 100 : 120,
                left: 150,
                duration: Duration(seconds: 2),
                child: Image(
                  height: 80,
                  image: AssetImage('assets/cloud3.png'),
                )),
            AnimatedPositioned(
                top: animateCloudOne ? 100 : 120,
                right: 20,
                duration: Duration(seconds: 2),
                child: Image(
                  height: 80,
                  image: AssetImage('assets/cloud3.png'),
                )),
            Positioned(
              bottom: w * 0.58,
              left: -10,
              child: Image(
                height: 80,
                color: Colors.black,
                image: AssetImage('assets/ghost_fixed.png'),
              ),
            ),
            Positioned(
              bottom: w * 0.58,
              right: -20,
              child: Image(
                height: 80,
                color: Colors.black,
                image: AssetImage('assets/ghost_fixed.png'),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async {
                  var xfile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (xfile != null) {
                    setState(() {
                      var image = File(xfile.path);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                    image: image,
                                  )));
                    });
                  }
                },
                child: Container(
                  height: 50,
                  width: w * 0.65,
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  decoration: ShapeDecoration(
                    color: Colors.pinkAccent,
                    shape: PixelBorder.shape(
                      borderRadius: BorderRadius.circular(16.0),
                      pixelSize: 8.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Choose a picture',
                      style: TextStyle(color: Colors.white, letterSpacing: 1.1),
                    ),
                  ),
                ),
              ),
            ),
            /* Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 150.0),
                height: 50,
                width: w * 0.65,
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                decoration: ShapeDecoration(
                  color: Colors.pinkAccent,
                  shape: PixelBorder.shape(
                    borderRadius: BorderRadius.circular(16.0),
                    pixelSize: 8.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    'About :)',
                    style: TextStyle(color: Colors.white, letterSpacing: 1.1),
                  ),
                ),
              ),
            ),*/
            AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Positioned(
                      bottom: 50,
                      left: animation.value,
                      child: Image(
                        height: 80,
                        color: Colors.black,
                        image: AssetImage('assets/ghost.png'),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
