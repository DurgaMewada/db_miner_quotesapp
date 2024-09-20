import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'intro_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/jerry-ubah-logo2.jpg',
              height: screenHeight * 0.25,
              width: screenWidth * 0.5,
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xff060A12),
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: IntroScreen(),
      duration: 5000,
      splashIconSize: screenWidth * 0.8,
    );
  }
}