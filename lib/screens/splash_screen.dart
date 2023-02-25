import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maps/main.dart';
import 'package:maps/screens/welcome_screen.dart';

class SplashScreenMaps extends StatelessWidget {
  const SplashScreenMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 300.0,
          width: 300.0,
          child: LottieBuilder.asset('assets/7213-lap.json')),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 10)).then((value) => Navigator.of(context)
        .pushReplacement(
            MaterialPageRoute(builder: (context) => WelcomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: 400.0,
            width: 200.0,
            child: Column(
              children: [
                LottieBuilder.asset('assets/mapanimation.json'),
                Text(
                  "Good Trips",
                  style: TextStyle(
                      color: HexColor('#115173'),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
      ),
    );
  }
}
