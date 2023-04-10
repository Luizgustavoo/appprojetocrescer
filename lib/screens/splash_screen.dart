import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:projetocrescer/screens/auth_or_home_page.dart';
import 'package:projetocrescer/widgets/clip_path.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthOrHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPathCustom(),
          Center(
            child: Container(
              width: 400,
              height: 400,
              child: RiveAnimation.asset(
                'images/projeto.riv',
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 350),
              child: SizedBox(
                width: 80,
                height: 80,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulseSync,
                  colors: [
                    Color(0xFF130B3B),
                    Color(0xFFEBAE1F),
                    Color(0XFFd7f1fa),
                  ],
                  strokeWidth: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
