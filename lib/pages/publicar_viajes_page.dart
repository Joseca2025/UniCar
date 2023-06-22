import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';
import 'package:unicar/pages/precise_pickup_location.dart';
import 'package:unicar/pages/search_places_screen.dart';

import '../assitan/assistant_methods.dart';
import '../global/global.dart';
import '../models/directions.dart';
import '../temas/app_info.dart';
import '../widgets/progress_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newGoogleMapController;
  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = Set<Polyline>();
  bool openNavigationDrawer=true;
  List<LatLng> polyCoordinate = [];
  PolylinePoints? polylinePoints;
  Geolocator? current;
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(-17.7864704, -63.193088),
    zoom: 14,
  );

  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(-17.7864704, -63.193088),
        infoWindow: InfoWindow(title: 'yo')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(-17.7864704, -63.193088),
        infoWindow: InfoWindow(title: 'yo')),
  ];
  Set<Polyline> polylineSet={};

  Set<Marker> markerSet={};
  Set<Circle> circleSet={};

  List<LatLng> pLineCoordinatedList=[];
  Future<void> drawPolyLineFromOriginToDestination(bool darkTheme) async{
    var originPosition= Provider.of<AppInfo>(context, listen: false).userPickUpLocation;
    var destinationPosition= Provider.of<AppInfo>(context, listen: false).userDropOffLocation;

    var originLatLng= LatLng(originPosition!.locationLatitude!, originPosition.locationLongitude!);
    var destinationLatLng= LatLng(destinationPosition!.locationLatitude!, destinationPosition.locationLongitude!);

    showDialog(
        context: context,
        builder: (BuildContext context)=> ProgressDialog(message: "Espere por favor...",)
    );

   var directionDetailsInfo= await AssistantMethods.obtainOriginToDestinationDirectionDetails(originLatLng, destinationLatLng);
   setState(() {
     tripDirectionDetailsInfo = directionDetailsInfo;
   });

   Navigator.pop(context);
   PolylinePoints pPoints= PolylinePoints();
   List<PointLatLng> decodePolyLinePointsResultList= pPoints.decodePolyline(directionDetailsInfo.e_points!);

   pLineCoordinatedList.clear();

   if(decodePolyLinePointsResultList.isNotEmpty){
     decodePolyLinePointsResultList.forEach((PointLatLng pointLatLng) { 
       pLineCoordinatedList.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
     });
   }

   polylineSet.clear();

   setState(() {
     Polyline polyline= Polyline(
       color: darkTheme? Colors.amberAccent : Colors.blue,
       polylineId: PolylineId("PolylineID"),
       jointType: JointType.round,
       points: pLineCoordinatedList,
       startCap: Cap.roundCap,
       endCap: Cap.roundCap,
       geodesic: true,
       width: 5,
     );

     polylineSet.add(polyline);
   });

   LatLngBounds boundsLatLng;
   if(originLatLng.latitude > destinationLatLng.latitude && originLatLng.longitude > destinationLatLng.longitude){
     boundsLatLng = LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
   }
   else if(originLatLng.longitude > destinationLatLng.longitude){
     boundsLatLng = LatLngBounds(
         southwest: LatLng(originLatLng.latitude,destinationLatLng.longitude),
         northeast: LatLng(destinationLatLng.latitude, originLatLng.longitude),
     );
   }
   else if(originLatLng.latitude > destinationLatLng.latitude){
     boundsLatLng = LatLngBounds(
       southwest: LatLng(destinationLatLng.latitude,originLatLng.longitude),
       northeast: LatLng(originLatLng.latitude, destinationLatLng.longitude),
     );
   }
   else{
     boundsLatLng = LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
   }
   
   newGoogleMapController!.animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 65));

   Marker originMarker= Marker(
       markerId: MarkerId("originID"),
     infoWindow: InfoWindow(title: originPosition.locationName,snippet: "Origin"),
     position: originLatLng,
     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
   );

    Marker destinationMarker= Marker(
      markerId: MarkerId("destinationID"),
      infoWindow: InfoWindow(title: destinationPosition.locationName,snippet: "Destination"),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    setState(() {
      markerSet.add(originMarker);
      markerSet.add(destinationMarker);
    });

    Circle originCircle= Circle(
      circleId: CircleId("OriginID"),
      fillColor: Colors.green,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: originLatLng,
    );

    Circle destinationCircle= Circle(
      circleId: CircleId("DestinationID"),
      fillColor: Colors.red,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: destinationLatLng,
    );

    setState(() {
      circleSet.add(originCircle);
      circleSet.add(destinationCircle);
    });
  }



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
  double bottomPaddingOfMap = 0;
  double suggestedRidesContainerHeight=0;

  void showSuggestedRidesContainer(){
    setState(() {
      suggestedRidesContainerHeight=400;
      bottomPaddingOfMap = 400;
    });
  }
  @override
  void initState() {
    super.initState();
    getPolyPoints();
    loadData();
    polylinePoints = PolylinePoints();
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness==Brightness.dark;
    return GestureDetector(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _kGoogle,
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polyCoordinate,
                  color: Colors.orange,
                  width: 6,
                ),
              },
              markers: Set<Marker>.of(_markers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: darkTheme ? Colors.amber.shade400 : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: darkTheme
                                  ? Colors.amber.shade100
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: darkTheme
                                            ? Colors.amber.shade300
                                            : Colors.blue.shade300,
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Punto de Partida",
                                            style: TextStyle(
                                              color: darkTheme
                                                  ? Colors.amber.shade300
                                                  : Colors.blue.shade400,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            Provider.of<AppInfo>(context)
                                                        .userPickUpLocation !=
                                                    null
                                                ? (Provider.of<AppInfo>(context)
                                                            .userPickUpLocation!
                                                            .locationName!)
                                                        .substring(0, 24) +
                                                    "..."
                                                : "Direccion no encontrada",
                                            style: TextStyle(
                                              color: Colors.grey.shade900,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  height: 1,
                                  thickness: 2,
                                  color: darkTheme
                                      ? Colors.amber.shade200
                                      : Colors.blue.shade400,
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: GestureDetector(
                                    onTap: () async {
                                      var responseFromSearchScreen =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      SearchPlacesScreen()));

                                      if (responseFromSearchScreen ==
                                          "obtainedDropoff") {
                                        setState(() {
                                          openNavigationDrawer = false;
                                        });
                                      }

                                      await drawPolyLineFromOriginToDestination(
                                          darkTheme);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: darkTheme
                                              ? Colors.amber.shade300
                                              : Colors.blue.shade300,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Destino",
                                              style: TextStyle(
                                                color: darkTheme
                                                    ? Colors.amber.shade300
                                                    : Colors.blue.shade500,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              Provider.of<AppInfo>(context)
                                                          .userDropOffLocation !=
                                                      null
                                                  ? Provider.of<AppInfo>(context)
                                                      .userDropOffLocation!
                                                      .locationName!
                                                  : "A donde?",
                                              style: TextStyle(
                                                color: Colors.grey.shade900,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) => PrecisePickUpScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Cambiar punto de partida",
                                  style: TextStyle(
                                    color: darkTheme ? Colors.black : Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: darkTheme
                                      ? Colors.amber.shade300
                                      : Colors.blue,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  if (Provider.of<AppInfo>(context, listen: false)
                                          .userDropOffLocation !=
                                      null) {
                                    showSuggestedRidesContainer();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Porfavor selecciona la ubicación destino");
                                  }
                                },
                                child: Text(
                                  "Mostrar tarifa",
                                  style: TextStyle(
                                    color: darkTheme ? Colors.black : Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: darkTheme
                                      ? Colors.amber.shade300
                                      : Colors.blue,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: loadData,
        child: Icon(
          Icons.local_activity,
          color: Colors.white,
        ),
      ),
      ),
      
    );
  }
}
