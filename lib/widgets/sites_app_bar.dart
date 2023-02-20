import 'package:flutter/material.dart';

class SitesAppBar extends StatelessWidget {
  const SitesAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: Text("sites",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue),),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
