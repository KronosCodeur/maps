import 'package:flutter/material.dart';

class HotelAppBar extends StatelessWidget {
  const HotelAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: Text("hotel",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue),),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
