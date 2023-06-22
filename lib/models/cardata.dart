import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
//import 'package:intl/intl.dart';

class CarData {
  final String name;
  final String uid;
  final String nro;
  final String cvc;
  //final DateFormat date;
  CarData({
    required this.name,
    required this.uid,
    required this.nro,
    required this.cvc,
  //  required this.date,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "nro": nro,
        "cvc": cvc,
       //"date": date,
      };

  static CarData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CarData(
      name: snapshot['name'],
      uid: snapshot['uid'],
      nro: snapshot['nro'],
      cvc: snapshot['cvc'],
      //date: snapshot['date'],
    );
  }
}