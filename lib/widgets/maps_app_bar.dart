import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps/main.dart';
class MapAppBar extends StatelessWidget {
  const MapAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: 50,
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Lomé,",textAlign: TextAlign.center,style: TextStyle(fontSize:25,color: HexColor('#115173'), fontWeight: FontWeight.bold,),),
          SizedBox(width: 1,),
          Text("Togo",textAlign: TextAlign.center,style: TextStyle(fontSize:25,color: HexColor('#115173'), fontWeight: FontWeight.bold,),),
          SizedBox(width: 5,),
          FaIcon(FontAwesomeIcons.mapMarkerAlt,color: HexColor("#ffd700"), size: 30,),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
