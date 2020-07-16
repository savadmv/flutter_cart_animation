import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RotationTest(),
    );
  }
}


class RotationTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RotationTestState();
}

class RotationTestState extends State<RotationTest>
    with TickerProviderStateMixin {
  AnimationController _controller;

  bool _first = true;

  AnimationController rotationController;

  AnimationController _controllerFast;

  AnimationController _controllerSlow;

  initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controllerSlow = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controllerFast = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    rotationController = AnimationController(
        duration: const Duration(seconds: 10), vsync: this, upperBound: pi * 2);
    super.initState();
    _controller.repeat(reverse: true);
    rotationController.repeat(reverse: true);
    _controllerFast.repeat(reverse: true);
    _controllerSlow.repeat(reverse: false);

  }
  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    rotationController.dispose();
    _controllerFast.dispose();
    _controllerSlow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    /// An interpolation between two relative rects.
    ///
    /// This class specializes the interpolation of [Tween<RelativeRect>] to
    /// use [RelativeRect.lerp].


    ///For Wheel One
    final RelativeRectTween relativeRectTweenWheelOne = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, size.width / 4, 0),
      end: RelativeRect.fromLTRB(0, 0, size.width / 4, 100),
    );

    ///For Wheel Two
    final RelativeRectTween relativeRectTweenWheelTwo = RelativeRectTween(
      begin: RelativeRect.fromLTRB(size.width / 4, 0, 0, 0),
      end: RelativeRect.fromLTRB(size.width / 4, 0, 0, 100),
    );

    ///For Cart
    final RelativeRectTween relativeRectTweenCart = RelativeRectTween(
      begin: RelativeRect.fromLTRB(-70, 0, 0, 280),
      end: RelativeRect.fromLTRB(-70, 0, 0, 320),
    );


    /// Tween for different items in the cart
    final RelativeRectTween relativeRectTweenMilk = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, 0, 350),
      end: RelativeRect.fromLTRB(0, 0, 50, 390),
    );

    final RelativeRectTween relativeRectTweenBag = RelativeRectTween(
      begin: RelativeRect.fromLTRB(-70, 0, 0, 340),
      end: RelativeRect.fromLTRB(0, 0, 0, 360),
    );
    final RelativeRectTween relativeRectTweenCheese = RelativeRectTween(
      begin: RelativeRect.fromLTRB(100, 0, 0, 280),
      end: RelativeRect.fromLTRB(100, 0, 0, 320),
    );

    final RelativeRectTween relativeRectTweenBottle = RelativeRectTween(
      begin: RelativeRect.fromLTRB(100, 0, 0, 320),
      end: RelativeRect.fromLTRB(100, 0, 0, 350),
    );

    /// //// //// //// //// //// END /// ///// //// //// ///// /////



    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: size.height,
            width: size.width,
            child: Stack(
              children: <Widget>[

                RotatingWheel(
                  controller: _controller,
                  rotationController: rotationController,
                  relativeRectTween: relativeRectTweenWheelOne,
                ),
                PositionedTransition(
                  rect: relativeRectTweenCart.animate(_controller),
                  child: Image.asset(
                    "assets/images/shopping_cart.png",
                    width: 1,
                    height: 1,
                  ),
                ),

                ///Bottle
                PositionedTransition(
                  rect: relativeRectTweenBottle.animate(_controllerFast),
                  child: Image.asset(
                    "assets/images/bottle.png",
                    width: 1,
                    height: 1,
                  ),
                ),
                ///Milk
                PositionedTransition(
                  rect: relativeRectTweenMilk.animate(_controllerFast),
                  child: Image.asset(
                    "assets/images/milk.png",
                    width: 1,
                    height: 1,
                  ),
                ),
                ///Cheese
                PositionedTransition(
                  rect: relativeRectTweenCheese.animate(_controllerFast),
                  child: Image.asset(
                    "assets/images/cheese.png",
                    width: 1,
                    height: 1,
                  ),
                ),
                ///Bag
                PositionedTransition(
                  rect: relativeRectTweenBag.animate(_controllerFast),
                  child: Image.asset(
                    "assets/images/bag.png",
                    width: 1,
                    height: 1,
                  ),
                ),

                RotatingWheel(
                  controller: _controller,
                  rotationController: rotationController,
                  relativeRectTween: relativeRectTweenWheelTwo,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(margin:EdgeInsets.only(bottom: 100),child: new Text("Shop Now",style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 38),)))
              ],
            ),
          ),
//        SizedBox(height: 20,),
//        FlatButton(
//          onPressed: () {
//            if (_first) {
//              _controller.forward();
//            } else {
//              _controller.reverse();
//            }
//            _first = !_first;
//          },
//          child: Text(
//            "CLICK ME!",
//            style: TextStyle(color: Colors.white),
//          ),
//        )
        ],
      ),
    );
  }
}

class RotatingWheel extends StatelessWidget {
  final RelativeRectTween relativeRectTween;
  final AnimationController controller;
  final AnimationController rotationController;

  const RotatingWheel(
      {Key key,
        this.relativeRectTween,
        this.controller,
        this.rotationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PositionedTransition(
      rect: relativeRectTween.animate(controller),
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
        child: Image.asset(
          "assets/images/wheel.png",
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}

