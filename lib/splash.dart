import 'package:flutter/material.dart';
import 'dart:async';

import 'package:moviesnearby/Home.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay navigation to MyHome by 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => Myhome(),
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double fontSize = MediaQuery.of(context).size.width * 0.06;
            if (fontSize > 24.0) {
              fontSize = 24.0;
            }

            return Text(
              'Movies Nearby',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
