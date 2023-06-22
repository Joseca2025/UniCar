import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Car {
  final String placa;
  final String modelo;
  final String caruid;
  // final String uidCustomer;
  final int kilometraje;
  final String photoUrl;
  final int year;

  const Car({
    required this.placa,
    required this.modelo,
    required this.caruid,
    //required this.uidCustomer,
    required this.kilometraje,
    required this.photoUrl,
    required this.year,
  });

  Map<String, dynamic> toJson() => {
        "placa": placa,
        "modelo": modelo,
        "caruid": caruid,
        //"uidCliente": uidCustomer,
        "kilometraje": kilometraje,
        "photoUrl": photoUrl,
        "year": year,
      };

  static Car fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Car(
        placa: snapshot['placa'],
        modelo: snapshot['modelo'],
        caruid: snapshot['caruid'],
        //uidCustomer: snapshot['uidCustomer'],
        kilometraje: snapshot['kilometraje'],
        photoUrl: snapshot['photoUrl'],
        year: snapshot['year']);
  }
}