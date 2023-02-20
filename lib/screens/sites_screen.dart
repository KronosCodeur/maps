import 'package:flutter/material.dart';

class SitesScreen extends StatefulWidget {
  const SitesScreen({Key? key}) : super(key: key);

  @override
  State<SitesScreen> createState() => _SitesScreenState();
}

class _SitesScreenState extends State<SitesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Sites'),
      ),
    );
  }
}
