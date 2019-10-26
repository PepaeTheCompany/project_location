import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login.dart';
class scoreview extends StatelessWidget {
  @override
  FirebaseDatabase database = new FirebaseDatabase();

  Widget build(BuildContext context) {

    int number = 10;
    TextEditingController nameController = new TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: Text("ผู้ดูแล"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextField(

                textAlign: TextAlign.center,
                controller: nameController,

                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter name',


                ),
              ),
              RaisedButton(
                  child: Text('insert'),
                  onPressed: () {
                    DatabaseReference databaseReference = database.reference()
                        .child('user');
                    databaseReference.child("a").set(<String, String>{
                      "name": nameController.text.toString(),
                    }).then((_) {
                      print('Transaction  committed.');
                    });
                    Fluttertoast.showToast(
                        msg: "บันทึก",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);

                  }
              ),
              RaisedButton(
                child: Text('show'),
                onPressed: () async {


                  DatabaseReference databaseReference = database.reference().child('attendant');
                  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  final String uid = user.uid.toString();

                  FirebaseDatabase.instance.reference().child("connect").orderByChild("uid_patient").equalTo(uid).once().then((DataSnapshot snapshot) {

                    final value = snapshot.value as Map;

                    // print(value[key]);
                    // print(snapshot.value);

                    value.forEach((key,values) {
                      String a= values["uid_attendant"];
                      print(a);
                    });

                  });


//                  databaseReference.child("5jXLof2LhQe455bJq4yQVteJWDS2").child("name").once().then((DataSnapshot snapshot) {
//
//
//                    Fluttertoast.showToast(
//                        msg: snapshot.value,
//                        toastLength: Toast.LENGTH_SHORT,
//                        gravity: ToastGravity.BOTTOM,
//                        timeInSecForIos: 1,
//                        backgroundColor: Colors.red,
//                        textColor: Colors.white,
//                        fontSize: 16.0);
//                  });
                },
              ),
              RaisedButton(
                child: Text('delete'),
                onPressed: () {

                  DatabaseReference databaseReference = database.reference().child('user');
                  databaseReference.child("a").remove().then((_) {
                    Fluttertoast.showToast(
                        msg: "ลบแล้ว",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                },
              ),

              RaisedButton(
                child: Text('signout'),
                onPressed: () {  signOut(context);
                },
              ),
            ],
          ),
        ),
      ),

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
}
