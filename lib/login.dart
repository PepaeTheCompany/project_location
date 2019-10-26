import 'package:firebase_database/firebase_database.dart';
import 'package:pj_location/home_attendant.dart';

import 'forgot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pj_location/register_patient.dart';
import 'home_patient.dart';
import 'register_attendant.dart';
class login extends StatefulWidget {
  login({Key key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();

}

class _MyLoginPageState extends State<login> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    checkAuth(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("เข้าสู่ระบบ", style: TextStyle(color: Colors.white)),
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
                      buildTextFieldPassword(),
                      buildButtonSignIn(),
                      buildOtherLine(),
                      buildButtonregister_attendant(),
                      buildButtonregister_patient(),
                      buildButtonforgot(),
                    ],
                  )
                  )
              ),
            )));
  }

  Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(height: 65,
        ),
        child: RaisedButton(
            color: Colors.green[200],
            child: Text('เข้าสู่ระบบ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black)),
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(14.0)),
            onPressed: () async {
              signIn();

            }
        ),
        decoration: BoxDecoration(
          ),
        padding: EdgeInsets.all(12));
  }
  Container buildButtonforgot() {
    return Container(
        constraints: BoxConstraints.expand(height: 65,
        ),
        child: RaisedButton(
            color: Colors.red[300],
            child: Text('ลืมรหัสผ่าน',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black)),
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(14.0)),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => forgot()),
              );
            }
        ),
        decoration: BoxDecoration(
        ),
        padding: EdgeInsets.all(12));
  }
  Widget buildOtherLine() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        child: Row(children: <Widget>[
          Expanded(child: Divider(color: Colors.green[800])),
          Padding(
              padding: EdgeInsets.all(0),
              child: Text("Don’t have an account?",
                  style: TextStyle(color: Colors.black87))),
          Expanded(child: Divider(color: Colors.green[800])),
        ]));
  }
  Container buildButtonregister_patient() {
    return Container(
        constraints: BoxConstraints.expand(height: 65,
        ),
        child: RaisedButton(
            color: Colors.orange[200],
            child: Text('สมัครสมาชิกผู้ป่วย',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black)),
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(14.0)),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => register_patient()),
              );
            }
        ),
        decoration: BoxDecoration(
        ),
        padding: EdgeInsets.all(12));
  }
  Container buildButtonregister_attendant() {
    return Container(
        constraints: BoxConstraints.expand(height: 65,
        ),
        child: RaisedButton(
            color: Colors.yellow[200],
            child: Text('สมัครสมาชิกผู้ดูแล',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black)),
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(14.0)),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => register_attentant()),
              );
            }
        ),
        decoration: BoxDecoration(
        ),
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

  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            controller: passwordController,
            style: TextStyle(fontSize: 18)));
  }
  signIn(){
    _auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((user) async {
      FirebaseUser user = await _auth.currentUser();

      if (user != null) {
        final FirebaseUser user = await FirebaseAuth.instance.currentUser();
        final String uid = user.uid.toString();
        FirebaseDatabase.instance.reference().child("information").orderByChild("uid").equalTo(uid).once().then((DataSnapshot snapshot) {

          final value = snapshot.value as Map;

          value.forEach((key,values) {
            String status = values["status"];
            if(status == "attendant"){   Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => home_attendant(user)));
            }
            else{   Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => home_patient(user)));
            }
          });
        });  }
      else{
        Fluttertoast.showToast(
            msg: 'กรอกข้อมูลผิดพลาด',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((error) {
      print(error);
    });
  }
  Future checkAuth(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      print("Already singed-in with");
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String uid = user.uid.toString();
      FirebaseDatabase.instance.reference().child("information").orderByChild("uid").equalTo(uid).once().then((DataSnapshot snapshot) {

        final value = snapshot.value as Map;

        value.forEach((key,values) {
String status = values["status"];
if(status == "attendant"){   Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => home_attendant(user)));
}
else{   Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => home_patient(user)));
}
        });
      });

    }
  }
}
