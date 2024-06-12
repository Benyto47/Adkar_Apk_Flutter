import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splashScreenTimer(){
    Timer(const Duration(seconds: 8), () async{
      Navigator.popAndPushNamed(context, "/home");
    });
  }

  @override
  void initState() {
    super.initState();

    splashScreenTimer();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashbg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Container(
              margin: const EdgeInsets.only(left: 40, top: 40),
              child: Column(
                children:  [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        AnimatedTextKit(
                            animatedTexts:  [
                              FadeAnimatedText("startTitle".tr, textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 45,)),
                             // TypewriterAnimatedText("أذكار", textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40,), speed: Duration(microseconds: 500)),
                            //  TypewriterAnimatedText("المسلم", textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40,), speed: Duration(microseconds: 500)),
                            ]
                        ), // "أذكار\n\nأدعية\n\nالمسلم"

                      ],
                    ),
                  ),

                  Container(
                    height: 100,
                    margin: const EdgeInsets.only(top: 100),
                    child: const SpinKitFadingCircle(
                      size: 60,
                      color: Colors.white,
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
