import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splashbg.png"),
              fit: BoxFit.fill,
            ),
          ),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, 
              children :const [ Text("Made by Tasmim Web",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20,)
              ),
            ]
            ),
          ),
        ),
      ),
    );
  }
}
