import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String google_api_key = "AIzaSyDok9U_DUC6pIVxDfp9H9RMQsGPYl5SZu0";
const Color primaryColor = Color(0xff293e74);
const double defaultPadding = 16.0;

List _items = [];
List<Marker> markers = [];
List<Marker> _marker = [];
int count = 0;

Future<void> readJson() async {
  final String response =
      await rootBundle.loadString('assets/touristic_sites.json');
  final data = await json.decode(response);
  _items = data["places"];
  print("j'ai ${_items.length} places");
  _items.forEach((element) {
    count += 1;
    Marker newmarker = Marker(
        markerId: MarkerId("$count"),
        position: LatLng(element["latitude"], element["longitude"]),
        infoWindow: InfoWindow(title: "${element["name"]}"));
    markers.add(newmarker);
  });
}
