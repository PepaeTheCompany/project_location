import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:pj_location/home_attendant.dart';

import 'forgot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pj_location/register_patient.dart';
import 'home_patient.dart';
import 'register_attendant.dart';

class add_patient extends StatefulWidget {
  FirebaseDatabase database = new FirebaseDatabase();
  final FirebaseUser user;

  add_patient(this.user, {Key key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<add_patient> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("เพิ่มผู้ป่วย", style: TextStyle(color: Colors.white)),
        ),
        body: Container(
            color: Colors.green[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.yellow[100], Colors.green[100]])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildTextFieldEmail(),
                      buildButtonSignIn(),
                    ],
                  ))),
            )));
  }

  Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(
          height: 65,
        ),
        child: RaisedButton(
            color: Colors.green[200],
            child: Text('เพิ่มผู้ป่วย',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(14.0)),
            onPressed: () async {
              add_patient();
            }),
        decoration: BoxDecoration(),
        padding: EdgeInsets.all(12));
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "Email"),
            controller: emailController,
            style: TextStyle(fontSize: 18)));
  }

  add_patient() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    final String email = user.email.toString();
    FirebaseDatabase database = new FirebaseDatabase();
    if (emailController.text.toString() == "" ||
        emailController.text.toString() == null) {
      Fluttertoast.showToast(
          msg: "กรุณากรอกอีเมลล์ผู้ป่วย",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      try {
        FirebaseDatabase.instance
            .reference()
            .child("information")
            .orderByChild("email")
            .equalTo(emailController.text.toString())
            .once()
            .then((DataSnapshot snapshot) {
          final value = snapshot.value as Map;
          if (snapshot.value == "" || snapshot.value == null) {
            Fluttertoast.showToast(
                msg: "ไม่มีสมาชิกใช้อีเมลล์นี้",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            int i = 0;
            value.forEach((key, values) async {
              String email_patient = values["email"];
              String uid_patient = values["uid"];
              String status = values["status"];
              i++;
              if (status == "attendant") {
                Fluttertoast.showToast(
                    msg: "้อีเมลล์นี้ไม่ใช่ผู้ป่วย",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (status == "patient") {
                List<String> namesFixed = new List<String>(20);
                final FirebaseUser user =
                    await FirebaseAuth.instance.currentUser();
                final String uid = user.uid.toString();
                FirebaseDatabase.instance
                    .reference()
                    .child("connect")
                    .orderByChild("uid_patient")
                    .equalTo(uid_patient)
                    .once()
                    .then((DataSnapshot snapshot) async {
                  String email_attendant = values["email_attendant"];
                  String email_patient1 = values["email_patient"];

                  final value = snapshot.value as Map;

                  final String email = user.email.toString();
                  value.forEach((key, values) {
                    String email_attendant = values["email_attendant"];
                    String email_patient1 = values["email_patient"];

                    if (email_attendant == email &&
                        email_patient1 == email_patient) {
                      namesFixed[0] = values["email_attendant"];
                    }
                  });
                  //final point = await  point_add(a);
                  if (namesFixed[0].toString() == email) {
                    Fluttertoast.showToast(
                        msg: "ผู้ป่วยถูกเพิ่มไว้แล้ว",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    final FirebaseUser user =
                        await FirebaseAuth.instance.currentUser();
                    final String uid = user.uid.toString();
                    final String email = user.email.toString();
                    FirebaseDatabase database = new FirebaseDatabase();
                    DatabaseReference databaseReference =
                        database.reference().child('connect');
                    databaseReference.push().set(<String, String>{
                      "email_patient": email_patient,
                      "uid_patient": uid_patient,
                      "email_attendant": email,
                      "uid_attendant": uid,
                    }).then((_) {
                      print('Transaction  committed.');
                    });

                    Fluttertoast.showToast(
                        msg: "เพิ่มผู้ป่วยเรียบร้อย",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                });
              }
            });
          }
        });
      } catch (error) {}
    }
  }

}
