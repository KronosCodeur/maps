import 'package:flutter/material.dart';

class TraditionsScreen extends StatefulWidget {
  const TraditionsScreen({Key? key}) : super(key: key);

  @override
  State<TraditionsScreen> createState() => _TraditionsScreenState();
}

class _TraditionsScreenState extends State<TraditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Traditions'),
      ),
    );
  }
}
