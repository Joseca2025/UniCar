import 'dart:async';
import 'dart:typed_data';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

//import 'package:taxi_si2/utils/colors.dart';

//import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = Set<Polyline>();
  List<LatLng> polyCoordinate = [];
  PolylinePoints? polylinePoints;
  Geolocator? current;
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(37.4193, -122.0905),
    zoom: 14,
  );

  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(37.4193, -122.0905),
        infoWindow: InfoWindow(title: 'yo')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(37.4126, -122.0700),
        infoWindow: InfoWindow(title: 'yo')),
  ];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyD-QH5mQYAo-KzQmLX7aOGMIZPy24ea9n4',
        PointLatLng(37.4193, -122.0905),
        PointLatLng(37.4126, -122.0700));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng points) =>
          polyCoordinate.add(LatLng(points.latitude, points.longitude)));
    }
    setState(() {});
  }

  loadData() {
    getUserCurrentLocation().then((value) async {
      print('mi ubicacion');
      print(value.latitude.toString() + "" + value.longitude.toString());

      _markers.add(Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'Mi locacion')));
      CameraPosition cameraPosition = CameraPosition(
          zoom: 14, target: LatLng(value.latitude, value.longitude));
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPolyPoints();
    loadData();
    polylinePoints = PolylinePoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGoogle,
        polylines: {
          Polyline(
              polylineId: PolylineId("route"),
              points: polyCoordinate,
              color: Colors.orange,
              width: 6),
        },
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: loadData,
        child: Icon(
          Icons.local_activity,
          color: Colors.white,
        ),
      ),
    );
  }
}
