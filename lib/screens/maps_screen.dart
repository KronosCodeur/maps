import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps/constants.dart';


class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {

  List _items = [];
  List <Marker> markers = [];
  List <Marker> _marker = [];
  int count =0;
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/touristic_sites.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["places"];
      print("j'ai ${_items.length} places");
      _items.forEach((element) {
        count+=1;
        Marker newmarker = Marker(
            markerId: MarkerId("$count"),
          position: LatLng(element["latitude"], element["longitude"]),
          infoWindow: InfoWindow(title: "${element["name"]}")
        );
        markers.add(newmarker);
      });
    });
  }

  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(6.2350683,1.4765624);
  static const LatLng destination = LatLng(7.1983303, 0.1983303
  );

  List<LatLng>polylineCoordinates = [];
  LocationData? currentLocation;

  void getCurrentLocation () async {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    },
    );
    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newloc) {
      
      currentLocation = newloc;
      /*googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 30,
              tilt: 80,
              target: LatLng(
              newloc.latitude!,
              newloc.longitude!))));*/
      setState(() {});
    });
  }
  void getPolyPoints() async{
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if(result.points.isNotEmpty){
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude),
      );
      }
      setState(() {
      });
    }
  }
  @override
  void initState(){
    getCurrentLocation();
    getPolyPoints();
    readJson();
    _marker.addAll(markers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: currentLocation==null
            ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Loading...",style: TextStyle(fontSize: 20, color: primaryColor, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                CircularProgressIndicator(
          color: primaryColor,
          strokeWidth: 5,
        ),
              ],
            ),)
            :GoogleMap(
              compassEnabled: true,
              mapType: MapType.hybrid,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onTap: (argument) {

              },
        trafficEnabled: true,

              initialCameraPosition: CameraPosition(target: sourceLocation, zoom: 13.5),
          polylines: {
          Polyline(polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: primaryColor,
            width: 6,
          ),
          },
          markers: Set<Marker>.of(markers),
          onMapCreated:(mapController){
              _controller.complete(mapController);
          },
        ),
    );
  }
}
