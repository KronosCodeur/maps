import 'package:flutter/material.dart';

class RestaurantAppBar extends StatelessWidget {
  const RestaurantAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: Text("Restaurant",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue),),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
