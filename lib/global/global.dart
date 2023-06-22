//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:users/models/direction_details_info.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/direction_details_info.dart';
//import '../models/user.dart';
///mport '../models/user_model.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentUser;
//User 
List driversList=[];
User? userModelCurrentInfo;


DirectionDetailsInfo? tripDirectionDetailsInfo;
String userDropOffAddress="";
String driverCarDetails="";
String driverName="";
String driverPhone="";

double countRatingStars=0.0;
String titleStarsRating="";