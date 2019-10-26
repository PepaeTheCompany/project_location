import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Database {

  static Future<Query> query_home_patient() async {
    List<String> namesFixed = new List<String>(20);
//    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    final String uid = user.uid.toString();
//    FirebaseDatabase.instance.reference().child("connect").orderByChild("uid_patient").equalTo(uid).once().then((DataSnapshot snapshot) {
//
//      final value = snapshot.value as Map;
//      int i=0;
//      value.forEach((key,values) {
//        namesFixed[i] = values["email_attendant"];
//        i++;
//      });
//    });
//    print(namesFixed[0]);
//    print(namesFixed[1]);


    return FirebaseDatabase.instance
        .reference()
        .child("attendant")
        .orderByChild("email");


  }
  static Future<Query> query_home_attendant() async {
    List<String> namesFixed = new List<String>(20);
//
//    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    final String uid = user.uid.toString();
//    FirebaseDatabase.instance.reference().child("connect").orderByChild("uid_patient").equalTo(uid).once().then((DataSnapshot snapshot) {
//
//      final value = snapshot.value as Map;
//      int i=0;
//      value.forEach((key,values) {
//        namesFixed[i] = values["email_attendant"];
//        i++;
//      });
//    });
//    print(namesFixed[0]);
//    print(namesFixed[1]);
    return FirebaseDatabase.instance
        .reference()
        .child("patient")
        .orderByChild("email");


  }

}

/// requires: intl: ^0.15.2
String _getDateNow() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return formatter.format(now);
}

