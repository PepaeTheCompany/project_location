import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pj_location/add_patient.dart';
import 'package:pj_location/constants_attendant.dart';
import 'database.dart';
import 'login.dart';
import 'account_attendant.dart';
import 'package:url_launcher/url_launcher.dart';
class home_attendant extends StatelessWidget {
  final FirebaseUser user;
  home_attendant(this.user, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Query _query;

  @override
  void initState() {




    Database.query_home_attendant().then((Query query) {
      setState(() {
        _query = query;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = new ListView(
      children: <Widget>[
        new ListTile(
          title: new Text("The list is empty..."),
        )
      ],
    );

    if (_query != null) {
      body = new FirebaseAnimatedList(
        query: _query,
        itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> animation,
            int index,
            ) {
          String mountainKey = snapshot.key;
          Map map = snapshot.value;
          String name = map['Firsname'] as String;
          String s = map['email'] as String;
          return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text('$name'),
                subtitle: Text('$s'),
                onTap: () {
                  _showSimpleDialog(mountainKey);
                },
              ),
              new Divider(
                height: 2.0,
              ),
            ],
          );
        },
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ผู้ดูแล"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){

              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: body,


    );
  }

  void signOut(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => login()),
        ModalRoute.withName('/'));
  }
  Future<void> choiceAction(String choice) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    if(choice == Constants.account){
      FirebaseUser user = await _auth.currentUser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => account_attendant(user)));
    }
    else if(choice == Constants.add){
      FirebaseUser user = await _auth.currentUser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => add_patient(user)));
    }
    else if(choice == Constants.map_all){

    }
    else if(choice == Constants.signout){
      signOut(context);
    }
  }
  void _showSimpleDialog(String mountainKey) {
    FirebaseDatabase database = new FirebaseDatabase();
    DatabaseReference databaseReference = database.reference().child('patient');
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('ตัวเลือก'),
            children: <Widget>[
              buildOtherLine(),
              SimpleDialogOption(
                onPressed: () {
                  databaseReference.child(mountainKey).child("phone").once().then((DataSnapshot snapshot) {
                    if(snapshot.value == "" || snapshot.value == null){
                      Fluttertoast.showToast(
                          msg: "ผู้ป่วยยังไม่ได้เพิ่มเบอร์โทร",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    else {
                      launch("tel://" + snapshot.value);
                    }
                  });
                },
                child: const Text('โทรหาผู้ป่วย'),
              ),
              buildOtherLine(),
              SimpleDialogOption(
                onPressed: () {
                },
                child: const Text('สถิติ'),
              ),
              buildOtherLine(),
              SimpleDialogOption(
                onPressed: () {

                },
                child: const Text('ดูตำแหน่ง'),
              ),
              buildOtherLine(),
              SimpleDialogOption(
                onPressed: () {

                },
                child: const Text('ดูตำแหน่งในอาคาร'),
              ),
              buildOtherLine(),
              SimpleDialogOption(
                onPressed: () {
                  delete(mountainKey);
                },
                child: const Text('ลบผู้ป่วย'),
              ),

            ],
          );
        });
  }
  Widget buildOtherLine() {
    return Container(
        child: Row(children: <Widget>[
          Expanded(child: Divider(color: Colors.green[800])),
        ]));
  }
  delete(String mountainKey) async {
    FirebaseDatabase database = new FirebaseDatabase();
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid_attendant = user.uid.toString();
    final String uid = user.uid.toString();
    FirebaseDatabase.instance.reference().child("connect").orderByChild("uid_attendant").equalTo(uid_attendant).once().then((DataSnapshot snapshot) {
      final value = snapshot.value as Map;
      value.forEach((key,values) {
        if( values["uid_attendant"].toString() == uid_attendant && values["uid_patient"].toString() == mountainKey){
          DatabaseReference databaseReference = database.reference().child('connect');
          databaseReference.child(key.toString()).remove().then((_) {
            Fluttertoast.showToast(
                msg: "ลบผู้ป่วยเรียบร้อย",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        }
      });
    });
  }
}