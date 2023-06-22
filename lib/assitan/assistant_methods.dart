import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:unicar/assitan/request_assistant.dart';

import '../global/global.dart';
import '../models/direction_details_info.dart';
import '../models/directions.dart';
import '../models/user.dart';
import '../temas/app_info.dart';

class AssistantMethods{
  
  static void readCurrentOnlineUserInfo() async {
    currentUser= firebaseAuth.currentUser;
    DatabaseReference userRef= FirebaseDatabase.instance
    .ref()
    .child("users")
    .child(currentUser!.uid);

    userRef.once().then((snap){
      if(snap.snapshot.value!=null){
        //userModelCurrentInfo= User.fromSnapshot(snap.snapshot);
      }
    });
  }

  static Future<String> searchAddressForGeographicCoOrdinates(Position position, context) async {
    String mapKey = "AIzaSyD-QH5mQYAo-KzQmLX7aOGMIZPy24ea9n4";
    String apiUrl= "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress="";

    var requestReponse= await RequestAssistant.receiveRequest(apiUrl);

    if(requestReponse!="Error Ocurrido. Fallo! No responde"){
      humanReadableAddress=requestReponse["results"][0]["formatted_address"];

      Directions userPickUpAddress= Directions();
      userPickUpAddress.locationLatitude=position.latitude;
      userPickUpAddress.locationLongitude=position.longitude;
      userPickUpAddress.locationName=humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
    }

    return humanReadableAddress;
  }

  static Future<DirectionDetailsInfo> obtainOriginToDestinationDirectionDetails(LatLng originPosition, LatLng destinationPosition) async{
    String mapKey = "AIzaSyD-QH5mQYAo-KzQmLX7aOGMIZPy24ea9n4";
    String urlOriginToDestinationDirectionDetails= "https://maps.googleapis.com/maps/api/directions/json?origin=${originPosition.latitude},${originPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapKey";

    var responseDirectionApi= await RequestAssistant.receiveRequest(urlOriginToDestinationDirectionDetails);

   // if(responseDirectionApi == "Error ocurrido.  No responde"){
     // return ;
  //  }

    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points= responseDirectionApi["routes"][0]["overview_polyline"]["points"];

    directionDetailsInfo.distance_text= responseDirectionApi["routes"][0]["legs"][0]["distance"]["text"];
    directionDetailsInfo.distance_value= responseDirectionApi["routes"][0]["legs"][0]["distance"]["value"];

    directionDetailsInfo.duration_text= responseDirectionApi["routes"][0]["legs"][0]["duration"]["text"];
    directionDetailsInfo.duration_value= responseDirectionApi["routes"][0]["legs"][0]["duration"]["value"];


    return directionDetailsInfo;
  }

  static double calculateFareAmountFromOriginToDestination(DirectionDetailsInfo directionDetailsInfo){
    double timeTraveledFareAmountPerMinute = (directionDetailsInfo.duration_value! / 60) *0.1;
    double distanceTraveledFareAmountPerKilometer= (directionDetailsInfo.duration_value!/1000)* 0.1;

    double totalFareAmount= timeTraveledFareAmountPerMinute + distanceTraveledFareAmountPerKilometer;

    return double.parse(totalFareAmount.toStringAsFixed(1));
  }

  static sendNotificationToDriverNow(String deviceRegistrationToken, String userRideRequestId, context) async{
    String destinationAddress= userDropOffAddress;

    /* Map<String, String> headerNotification={
      'Content-Type':'application/json',
      'Authorization': cloudMessagingServerToken,
    }; */

    Map bodyNotificacion={
      "body": "Destination Address: \n $destinationAddress.",
      "title":"Nuevo Viaje Requerido"
    };

    Map dataMap={
      "click_action": "FLUTTER_NOTIFICACION_CLICK",
      "id":"1",
      "status":"done",
      "rideRequestId": userRideRequestId
    };

    Map officialNotificationFormat={
      "notification": bodyNotificacion,
      "data": dataMap,
      "priority":"high",
      "to": deviceRegistrationToken,
    };

    /* var reponseNotificacion = http.post(
      Uri.parse("http://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    ); */
  }
}