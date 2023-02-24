import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreenMaps extends StatelessWidget {
  const SplashScreenMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 300.0,
          width: 300.0,
          child: LottieBuilder.asset('assets/7213-lap.json')
      ),
    );
  }
}
